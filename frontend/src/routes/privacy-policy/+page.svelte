<script lang="ts">
  import { page } from "$app/state";
  import type { PageProps } from "./$types";

  let { data }: PageProps = $props();
  let { contactInformation } = data;

  const canonicalUrl = page.url.href;
  const ogImageUrl = `${page.url.origin}/images/og-main.jpg`;
</script>

<svelte:head>
  <title>Polityka Prywatności | TAPO Apartamenty Krynica-Zdrój</title>

  <meta name="description" content="Polityka prywatności | TAPO Apartamenty w Krynicy-Zdroju." />

  <meta property="og:title" content="Polityka prywatności | TAPO Apartamenty Krynica-Zdrój" />
  <meta property="og:description" content="Polityka prywatności TAPO Apartamenty w Krynica-Zdroju" />
  <meta property="og:type" content="website" />
  <meta property="og:url" content={canonicalUrl} />

  <meta property="og:image" content={ogImageUrl} />
  <meta property="og:image:width" content="1200" />
  <meta property="og:image:height" content="630" />

  <link rel="canonical" href={canonicalUrl} />
</svelte:head>

<div class="container numbered text-justify px-2.5 mx-auto py-12 text-gray-800 leading-relaxed space-y-6">
  <h1 class="text-center font-medium">Informacja dotycząca przetwarzania danych osobowych przez TAPO Apartamenty</h1>

  <p>
    Administratorem danych osobowych jest TAPO Apartamenty Aleksandra Bisztyga z siedzibą przy ulicy Kraszewskiego 74,
    33-380 Krynica-Zdrój. Kontakt z administratorem jest możliwy za pośrednictwem adresu e-mail <a
      href={`mailto:${contactInformation.email}`}
      class="hover:underline">{contactInformation.email}</a
    >
    lub telefonicznie pod numerem
    <a href={`tel:${contactInformation.phone}`} class="hover:underline">{contactInformation.phone}</a>. Administrator
    danych nie powołał inspektora ochrony danych osobowych.
  </p>

  <p>
    Dane osobowe są przetwarzane w celu zrealizowania poniżej wymienionych usług:
    <span class="block pl-6">
      a) zawarcia umowy o świadczenie usług najmu i innych, podobnych usług związanych z pobytem w apartamentach,
    </span>
    <span class="block pl-6">b) uiszczenia opłaty uzdrowiskowej,</span>
    <span class="block pl-6">c) wystawienia faktury VAT.</span>
  </p>

  <p>
    Przetwarzaniu podlegają następujące dane osobowe:
    <span class="block pl-6">a) imię i nazwisko,</span>
    <span class="block pl-6">b) dane adresowe,</span>
    <span class="block pl-6">c) numer rachunku bankowego,</span>
    <span class="block pl-6">d) adres e-mail i numer telefonu,</span>
    <span class="block pl-6">
      e) dane z zapisu z urządzeń rejestrujących obraz umieszczonych na parkingu oraz w przestrzeniach wspólnych.
    </span>
    Zbieranie i przetwarzanie tych danych jest uzasadnione zapewnieniem bezpieczeństwa na terenie obiektu. Jednocześnie podstawowe
    prawa i wolności osób, których dane są przetwarzane, nie są naruszone. Dane osobowe są przetwarzane w oparciu o art.
    6 ust. 1 <span class="whitespace-nowrap">lit. a - f</span> RODO.
  </p>

  <p>
    Dane osobowe mogą być przekazywane poniższym podmiotom:
    <span class="block pl-6">a) podmiotom świadczącym usługi księgowe,</span>
    <span class="block pl-6">b) podmiotom świadczącym usługi prawne,</span>
    <span class="block pl-6">
      c) organom podatkowym w zakresie uiszczenia opłaty uzdrowiskowej i pozostałych należności podatkowych,
    </span>
    <span class="block pl-6">d) podmiotom świadczącym usługi informatyczne,</span>
    <span class="block pl-6">e) podmiotom świadczącym usługi ubezpieczeniowe.</span>
  </p>

  <p>
    Dane osobowe nie są przekazywane państwom trzecim ani innym organizacjom międzynarodowym. Dane osobowe nie podlegają
    zautomatyzowanemu podejmowaniu decyzji, w tym profilowaniu.
  </p>

  <p>
    Dane osobowe są przechowywane przez okres świadczenia usługi najmu, a po zakończeniu tego okresu przez okres
    wymagany przepisami podatkowymi oraz do czasu przedawnienia roszczeń, w tym roszczeń cywilnych. Dane z zapisu z
    urządzeń rejestrujących obraz są przechowywane przez 30 dni od czasu zakończenia usługi najmu. W uzasadnionych
    przypadkach okres ten może ulec wydłużeniu, w szczególności gdy zapis jest dowodem w postępowaniu.
  </p>

  <p>
    Osoba, której dane osobowe są przetwarzane, ma prawo dostępu do danych, sprostowania danych, usunięcia danych,
    ograniczenia przetwarzania, przenoszenia danych oraz sprzeciwu wobec przetwarzania. Osoba, której dane są
    przetwarzane, ma prawo wniesienia skargi do Prezesa Urzędu Ochrony Danych Osobowych.
  </p>
</div>
