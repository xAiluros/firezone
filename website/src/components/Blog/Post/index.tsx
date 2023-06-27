import Image from "next/image";
import gravatar from "@/lib/gravatar";

export default function Post({
  authorName,
  authorTitle,
  authorEmail,
  title,
  date,
  children,
}: {
  authorName: string;
  authorTitle: string;
  authorEmail: string;
  title: string;
  date: string;
  children: React.ReactNode;
}) {
  return (
    <>
      <div className="bg-violet-50 mx-auto w-screen text-center lg:mb-16 mb-8">
        <Image
          alt="Firezone logo"
          width={250}
          height={250}
          src="/images/logo-main.svg"
          className="my-12 mx-auto"
        />
      </div>

      <main className="pb-16 lg:pb-24 bg-white dark:bg-gray-900">
        <div className="flex justify-between px-4 mx-auto max-w-screen-xl">
          <article className="mx-auto w-full max-w-2xl format format-sm sm:format-base lg:format-lg format-blue dark:format-invert">
            <header className="mb-4 lg:mb-6 not-format">
              <address className="flex items-center mb-6 not-italic">
                <div className="inline-flex items-center mr-3 text-sm text-gray-900 dark:text-white">
                  <Image
                    width={64}
                    height={64}
                    className="mr-4 w-16 h-16 rounded-full"
                    src={gravatar(authorEmail)}
                    alt={authorName}
                  />
                  <div>
                    <a
                      href="#"
                      rel="author"
                      className="text-xl font-bold text-gray-900 dark:text-white"
                    >
                      {authorName}
                    </a>
                    <p className="text-base font-light text-gray-500 dark:text-gray-400">
                      {authorTitle}
                    </p>
                    <p className="text-base font-light text-gray-500 dark:text-gray-400">
                      <time dateTime="2022-02-08" title="February 8th, 2022">
                        {date}
                      </time>
                    </p>
                  </div>
                </div>
              </address>
              <h1 className="mb-4 text-3xl font-extrabold leading-tight text-gray-900 lg:mb-6 lg:text-5xl dark:text-white">
                {title}
              </h1>
            </header>
            {children}
          </article>
        </div>
      </main>

      {/* TODO: Related articles (see flowbite blocks) */}

    </>
  );
}
