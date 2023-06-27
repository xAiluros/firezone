defmodule FzHttpWeb.UserFromAuthTest do
  use FzHttp.DataCase, async: true
  alias FzHttp.UsersFixtures
  alias FzHttpWeb.UserFromAuth
  alias FzHttp.Users
  alias Ueberauth.Auth

  @moduletag email: "sso@test"

  describe "find_or_create/1 via identity provider" do
    test "sign in via identity provider" do
      user = UsersFixtures.create_user_with_role(:unprivileged)

      assert {:ok, result} =
               UserFromAuth.find_or_create(%Auth{
                 provider: :identity,
                 info: %Auth.Info{email: user.email},
                 credentials: %Auth.Credentials{other: %{password: "password1234"}}
               })

      assert result.email == user.email
    end
  end

  describe "find_or_create/2 via OIDC with auto create enabled" do
    test "sign in creates user", %{email: email} do
      FzHttp.ConfigFixtures.start_openid_providers(["google"], %{
        "auto_create_users" => true
      })

      assert {:ok, result} =
               UserFromAuth.find_or_create("google", %{
                 "email" => email,
                 "sub" => :noop
               })

      assert result.email == email
    end
  end

  describe "find_or_create/2 via OIDC with auto create disabled" do
    test "sign in returns error", %{email: email} do
      {_bypass, [openid_connect_provider_attrs]} =
        FzHttp.ConfigFixtures.start_openid_providers(["google"])

      openid_connect_provider_attrs =
        Map.put(openid_connect_provider_attrs, "auto_create_users", false)

      FzHttp.Config.put_config!(
        :openid_connect_providers,
        [openid_connect_provider_attrs]
      )

      assert {:error, "user not found and auto_create_users disabled"} =
               UserFromAuth.find_or_create(openid_connect_provider_attrs["id"], %{
                 "email" => email,
                 "sub" => :noop
               })

      assert Users.fetch_user_by_email(email) == {:error, :not_found}
    end
  end

  describe "find_or_create/2 via SAML with auto create enabled" do
    @tag config: [FzHttp.ConfigFixtures.saml_identity_providers_attrs()]
    test "sign in creates user", %{config: config, email: email} do
      FzHttp.Config.put_config!(:saml_identity_providers, config)

      assert {:ok, result} =
               UserFromAuth.find_or_create(:saml, "test", %{"email" => email, "sub" => :noop})

      assert result.email == email
    end
  end

  describe "find_or_create/2 via SAML with auto create disabled" do
    @tag config: [
           FzHttp.ConfigFixtures.saml_identity_providers_attrs(%{"auto_create_users" => false})
         ]
    test "sign in returns error", %{email: email, config: config} do
      FzHttp.Config.put_config!(:saml_identity_providers, config)

      assert {:error, "user not found and auto_create_users disabled"} =
               UserFromAuth.find_or_create(:saml, "test", %{"email" => email, "sub" => :noop})

      assert Users.fetch_user_by_email(email) == {:error, :not_found}
    end
  end

  describe "find_or_create/2 with missing email" do
    assert {:error, "unknown provider or email not found in params"} =
             UserFromAuth.find_or_create("dummy", %{"sub" => "1234"})
  end
end
