<script>
  import { SquareParking, Bath, CookingPot, Wifi, TvMinimalPlay, MapPinHouse } from "@lucide/svelte";
  import SectionTitle from "./SectionTitle.svelte";

  const amenities = [
    {
      title: "Darmowy Parking",
      icon: SquareParking,
      description: "Miejsce parkingowe dostępne bez dodatkowych opłat, tuż obok apartamentu.",
    },
    {
      title: "Prywatna Łazienka",
      icon: Bath,
      description: "Łazienka na wyłączny użytek gości, zapewniająca pełen komfort i prywatność.",
    },
    {
      title: "Wyposażona Kuchnia",
      icon: CookingPot,
      description: "Kuchnia z niezbędnymi sprzętami i naczyniami do przygotowywania posiłków.",
    },
    { title: "Darmowe WiFi", icon: Wifi, description: "Bezpłatny dostęp do szybkiego internetu w całym apartamencie." },
    {
      title: "Smart TV",
      icon: TvMinimalPlay,
      description:
        "Nowoczesny telewizor z dostępem do platform streamingowych, idealny na relaks po dniu pełnym wrażeń.",
    },
    {
      title: "Lokalizacja w centrum",
      icon: MapPinHouse,
      description: "Apartament położony w samym sercu miasta, blisko najważniejszych atrakcji w mieście.",
    },
  ];
</script>

<section>
  <div class="container mx-auto mb-8 xl:mb-12">
    <SectionTitle text="Udogodnienia dla naszych gości" />

    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-6 gap-3 md:gap-4">
      {#each amenities as amenity}
        <div
          class="p-3 md:p-5 xl:p-6 bg-white rounded-lg border border-gray-200 hover:border-primary-500 transition-all
         flex flex-row sm:flex-col items-center sm:items-center gap-4 sm:gap-0 text-left sm:text-center"
        >
          <!-- Icon -->
          <div
            class="relative w-12 h-12 sm:w-16 sm:h-16 flex-shrink-0 flex items-center justify-center sm:mb-4 sm:mx-auto"
          >
            <div
              class="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(59,130,246,0.15)_0%,transparent_60%)] backdrop-blur-sm"
            ></div>
            <div
              class="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(59,130,246,0.15)_10%,transparent_70%)]"
            ></div>
            <svelte:component this={amenity.icon} class="w-8 h-8 sm:w-10 sm:h-10 text-primary-500 relative z-10" />
          </div>

          <!-- Text -->
          <div>
            <h3 class="text-lg sm:text-lg font-semibold text-gray-800 mb-1 sm:mb-2">{amenity.title}</h3>
            <p class="text-sm sm:text-sm text-gray-600 hidden sm:block">{amenity.description}</p>
          </div>
        </div>
      {/each}
    </div>
  </div>
</section>
