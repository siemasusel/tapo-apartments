<script lang="ts">
  import { page } from "$app/state";

  const canonicalUrl = page.url.href;
  const ogImageUrl = `${page.url.origin}/images/og-main.jpg`;
</script>

<svelte:head>
  <title>Polityka Prywatności | TAPO Apartamenty Krynica-Zdrój</title>

  <meta name="description" content="Regulamin pobytu | TAPO Apartamenty w Krynicy-Zdroju." />

  <meta property="og:title" content="Regulamin pobytu | TAPO Apartamenty Krynica-Zdrój" />
  <meta property="og:description" content="Regulamin pobytu w TAPO Apartamenty w Krynica-Zdroju" />
  <meta property="og:type" content="website" />
  <meta property="og:url" content={canonicalUrl} />

  <meta property="og:image" content={ogImageUrl} />
  <meta property="og:image:width" content="1200" />
  <meta property="og:image:height" content="630" />

  <link rel="canonical" href={canonicalUrl} />
</svelte:head>

<div class="container text-justify px-2.5 mx-auto py-12 text-gray-800 leading-relaxed space-y-6">
  <h1 class="text-center font-medium">Regulamin pobytu w TAPO Apartamenty</h1>

  <span class="numbered block space-y-4">
    <h2 class="font-semibold">§ 1 Postanowienia ogólne</h2>
    <p>
      Niniejszy regulamin reguluje zasady świadczenia usług między TAPO Apartamenty, dalej jako Wynajmujący, oraz
      Najemcą.
    </p>
    <p>
      Regulamin jest integralną częścią umowy o świadczenie usług najmu krótkoterminowego. Najemca poprzez dokonanie
      rezerwacji zobowiązuje się do przestrzegania postanowień niniejszego regulaminu.
    </p>
    <p>
      Zawarcie umowy oznacza zaakceptowanie informacji dotyczącej przetwarzania danych osobowych przez Wynajmującego,
      dostępnej w zakładce
      <a href="/privacy-policy" class="hover:underline">Polityka prywatności</a>.
    </p>
  </span>

  <span class="numbered block space-y-4">
    <h2 class="font-semibold">§ 2 Rezerwacja</h2>
    <p>
      Rezerwacja usługi odbywa się telefonicznie lub mailowo poprzez dane dostępne na stronie internetowej, a także
      przez portale rezerwacyjne.
    </p>
    <p>Rezerwację uważa się za potwierdzoną po dokonaniu całości wpłaty na wskazany rachunek bankowy.</p>
    <p>Najemca ma prawo zrezygnować z pobytu, o czym należy poinformować Wynajmującego telefonicznie lub mailowo.</p>
    <p>
      W przypadku odwołania rezerwacji wpłacona kwota podlega zwrotowi w całości, jeżeli rezygnacja została zgłoszona
      najpóźniej na 7 dni przed rozpoczęciem pobytu.
    </p>
    <p>
      Wpłacona kwota przepada w całości w przypadku odwołania rezerwacji na krócej niż 7 dni przed rozpoczęciem pobytu.
    </p>
  </span>

  <span class="numbered block space-y-4">
    <h2 class="font-semibold">§ 3 Zameldowanie</h2>
    <p>
      Doba hotelowa trwa od godziny 14:00 do godziny 11:00 następnego dnia. Pozostanie w pokoju po tym czasie uważa się
      za przedłużenie doby.
    </p>
    <p>
      Zameldowanie i wymeldowanie odbywa się zgodnie z instrukcjami przekazanymi przez Wynajmującego telefonicznie,
      mailowo lub poprzez portal rezerwacyjny.
    </p>
    <p>
      Do każdego apartamentu przypisane jest jedno miejsce parkingowe w wyznaczonym miejscu. Korzystanie z dodatkowych
      miejsc parkingowych oraz parkowanie w miejscach niewyznaczonych do tego jest zabronione, chyba że Wynajmujący
      wyrazi na to uprzednio zgodę.
    </p>
    <p>Cisza nocna trwa od godziny 22.00 do godziny 7.00. W tym czasie zabrania się organizowania głośnych przyjęć.</p>
    <p>Osoby niezameldowane mogą przebywać na terenie obiektu w godzinach od 7.00 do 22.00.</p>
    <p>
      Po zakończeniu pobytu Najemca jest zobowiązany do pozostawienia klucza oraz mini pilota zgodnie z instrukcjami
      Wynajmującego. W przypadku ich zagubienia Wynajmujący może obciążyć Najemcę kosztami w wysokości 300 zł.
    </p>
  </span>

  <span class="numbered block space-y-4">
    <h2 class="font-semibold">§ 4 Zasady pobytu</h2>
    <p>
      Najemca ponosi odpowiedzialność za wszelkie szkody, zniszczenia lub utratę elementów wyposażenia apartamentu,
      powstałe z jego winy lub z winy osób, które przebywają w apartamencie za jego zgodą.
    </p>
    <p>
      Zabrania się palenia papierosów, papierosów elektronicznych i innych wyrobów tytoniowych w apartamentach, na
      balkonach i w częściach wspólnych. Palenie jest dozwolone wyłącznie w wyznaczonej strefie obok parkingu. Złamanie
      zakazu skutkuje opłatą w wysokości 500 zł.
    </p>
    <p>
      W apartamentach obowiązuje bezwzględny zakaz trzymania zwierząt. Naruszenie zakazu skutkuje opłatą w wysokości 500
      zł.
    </p>
    <p>
      Obowiązuje całkowity zakaz używania otwartego ognia, w tym świec, kadzidełek, podgrzewaczy, fajerwerków, grilli,
      kuchenek gazowych i innych urządzeń mogących stanowić źródło ognia. W przypadku naruszenia zakazu, Wynajmujący
      obciąży Najemcę opłatą 500 zł oraz ewentualnymi kosztami interwencji służb ratunkowych.
    </p>
  </span>
</div>
