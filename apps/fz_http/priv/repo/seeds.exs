# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FzHttp.Repo.insert!(%FzHttp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias FzHttp.{
  Repo,
  ConnectivityChecks,
  Devices,
  Users,
  ApiTokens,
  Rules,
  Auth.MFA
}

create_device = fn user, attrs ->
  Devices.Device.Changeset.create_changeset(user, attrs)
  |> Devices.Device.Changeset.configure_changeset(attrs)
  |> Repo.insert()
end

{:ok, unprivileged_user1} =
  Users.create_user(:unprivileged, %{
    email: "firezone-unprivileged-1@localhost"
  })

{:ok, _device} =
  create_device.(unprivileged_user1, %{
    name: "My Device",
    description: "foo bar",
    preshared_key: "27eCDMVRVFfMVS5Rfnn9n7as4M6MemGY/oghmdrwX2E=",
    public_key: "4Fo+SBnDJ6hi8qzPt3nWLwgjCVwvpjHL35qJeatKwEc=",
    remote_ip: %Postgrex.INET{address: {127, 5, 0, 1}},
    dns: ["8.8.8.8", "8.8.4.4"],
    allowed_ips: [
      %Postgrex.INET{address: {0, 0, 0, 0}, netmask: 0},
      %Postgrex.INET{address: {0, 0, 0, 0, 0, 0, 0, 0}, netmask: 0},
      %Postgrex.INET{address: {1, 1, 1, 1}}
    ],
    use_default_allowed_ips: false,
    use_default_dns: false,
    rx_bytes: 123_917_823,
    tx_bytes: 1_934_475_211_087_234
  })

{:ok, mfa_user} =
  Users.create_user(:unprivileged, %{
    email: "firezone-mfa@localhost",
    password: "firezone1234",
    password_confirmation: "firezone1234"
  })

secret = NimbleTOTP.secret()

MFA.create_method(
  %{
    name: "Google Authenticator",
    type: :totp,
    payload: %{"secret" => Base.encode64(secret)},
    code: NimbleTOTP.verification_code(secret)
  },
  mfa_user.id
)

{:ok, user} =
  Users.create_user(:admin, %{
    email: "firezone@localhost",
    password: "firezone1234",
    password_confirmation: "firezone1234"
  })

{:ok, _api_token} = ApiTokens.create_api_token(user, %{"expires_in" => 5})
{:ok, _api_token} = ApiTokens.create_api_token(user, %{"expires_in" => 30})
{:ok, _api_token} = ApiTokens.create_api_token(user, %{"expires_in" => 1})

{:ok, _device} =
  create_device.(user, %{
    name: "wireguard-client",
    description: """
    Test device corresponding to the client configuration used in the wireguard-client container
    """,
    preshared_key: "C+Tte1echarIObr6rq+nFeYQ1QO5xo5N29ygDjMlpS8=",
    public_key: "pSLWbPiQ2mKh26IG1dMFQQWuAstFJXV91dNk+olzEjA=",
    mtu: 1280,
    persistent_keepalive: 25,
    allowed_ips: [
      %Postgrex.INET{address: {0, 0, 0, 0}, netmask: 0},
      %Postgrex.INET{address: {0, 0, 0, 0, 0, 0, 0, 0}, netmask: 0}
    ],
    endpoint: "elixir",
    dns: ["127.0.0.11"],
    use_default_allowed_ips: false,
    use_default_dns: false,
    use_default_endpoint: false,
    use_default_mtu: false,
    use_default_persistent_keepalive: false
  })

{:ok, _device} =
  create_device.(user, %{
    name: "Factory Device 3",
    description: "foo 3",
    preshared_key: "23eCDMVRVFfMVS5Rfnn9n7as4M6MemGY/oghmdrwX2E=",
    public_key: "3Fo+SBnDJ6hi8q4Pt3nWLwgjCVwvpjHL35qJeatKwEc=",
    remote_ip: %Postgrex.INET{address: {127, 1, 0, 1}},
    rx_bytes: 123_917_823,
    tx_bytes: 1_934_475_211_087_234
  })

{:ok, _device} =
  create_device.(user, %{
    name: "Factory Device 5",
    description: "foo 3",
    preshared_key: "23eCDMVRbFfMVS5Rfnn9n7as4M6MemGY/oghmdrwX2E=",
    public_key: "3Fo+SBnDJ6hb8q4Pt3nWLwgjCVwvpjHL35qJeatKwEc=",
    remote_ip: %Postgrex.INET{address: {127, 3, 0, 1}},
    rx_bytes: 123_917_823,
    tx_bytes: 1_934_475_211_087_234
  })

{:ok, _device} =
  create_device.(user, %{
    name: "Factory Device 4",
    description: "foo 3",
    preshared_key: "2yeCDMVRVFfMVS5Rfnn9n7as4M6MemGY/oghmdrwX2E=",
    public_key: "3Fo+nBnDJ6hi8q4Pt3nWLwgjCVwvpjHL35qJeatKwEc=",
    remote_ip: %Postgrex.INET{address: {127, 4, 0, 1}},
    rx_bytes: 123_917_823,
    tx_bytes: 1_934_475_211_087_234
  })

{:ok, user} =
  Users.create_user(:admin, %{
    email: "firezone2@localhost",
    password: "firezone1234",
    password_confirmation: "firezone1234"
  })

{:ok, _device} =
  create_device.(user, %{
    name: "Factory Device 2",
    description: "foo 2",
    preshared_key: "27eCDMVRVFfMVS5Rfnn9n7as4M6MemGY/oghmdrwX2E=",
    public_key: "3Fo+SBnDJ6hi8qzPt3nWLwgjCVwvpjHL35qJeatKwEc=",
    remote_ip: %Postgrex.INET{address: {127, 5, 0, 1}},
    rx_bytes: 123_917_823,
    tx_bytes: 1_934_475_211_087_234
  })

{:ok, _device} =
  create_device.(user, %{
    name: "Factory Device",
    description: """
    Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. A\
    enean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus\
     mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat ma\
    ssa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim ju\
    sto, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pret\
    ium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifen\
    d tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem \
    ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius la\
    oreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorpe\
    r ultricies nisi. Nam eget dui. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aen\
    ean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis partu\
    rient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, preti\
    um quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, \
    vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam \
    dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum sempe\
    r nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, e\
    leifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus \
    viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi\
     vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Lorem ipsum dolor sit amet, c\
    onsectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoq\
    ue penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultri\
    cies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede jus\
    to\
    """,
    preshared_key: "27eCDMVvVFfMVS5Rfnn9n7as4M6MemGY/oghmdrwX2E=",
    public_key: "3Fo+SNnDJ6hi8qzPt3nWLwgjCVwvpjHL35qJeatKwEc=",
    remote_ip: %Postgrex.INET{address: {127, 6, 0, 1}},
    rx_bytes: 123_917_823,
    tx_bytes: 1_934_475_211_087_234
  })

{:ok, _connectivity_check} =
  ConnectivityChecks.ConnectivityCheck.Changeset.create_changeset(%{
    response_headers: %{"Content-Type" => "text/plain"},
    response_body: "127.0.0.1",
    response_code: 200,
    url: "https://ping-dev.firez.one/0.1.19"
  })
  |> Repo.insert()

{:ok, _connectivity_check} =
  ConnectivityChecks.ConnectivityCheck.Changeset.create_changeset(%{
    response_headers: %{"Content-Type" => "text/plain"},
    response_body: "127.0.0.1",
    response_code: 400,
    url: "https://ping-dev.firez.one/0.20.0"
  })
  |> Repo.insert()

Rules.create_rule(%{
  destination: "10.0.0.0/24",
  port_type: :tcp,
  port_range: "100-200"
})

Rules.create_rule(%{
  destination: "1.2.3.4"
})

FzHttp.Config.put_config!(:default_client_dns, ["4.3.2.1", "1.2.3.4"])

FzHttp.Config.put_config!(
  :default_client_allowed_ips,
  [
    %Postgrex.INET{address: {10, 0, 0, 1}, netmask: 20},
    %Postgrex.INET{address: {0, 0, 0, 0, 0, 0, 0, 0}, netmask: 0},
    %Postgrex.INET{address: {1, 1, 1, 1}}
  ]
)

FzHttp.Config.put_config!(:default_client_connected_sites, [])

FzHttp.Config.put_config!(
  :openid_connect_providers,
  [
    %{
      "id" => "vault",
      "discovery_document_uri" => "https://common.auth0.com/.well-known/openid-configuration",
      "client_id" => "CLIENT_ID",
      "client_secret" => "CLIENT_SECRET",
      "redirect_uri" => "http://localhost:13000/auth/oidc/vault/callback/",
      "response_type" => "code",
      "scope" => "openid email offline_access",
      "label" => "OIDC Vault",
      "auto_create_users" => true
    }
  ]
)
