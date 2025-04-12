<script>
  import { SquareParking, Bath, CookingPot, Wifi, TvMinimalPlay, MapPinHouse } from "lucide-svelte";

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

<section class="">
  <div class="container mx-auto pb-12">
    <h2 class="text-3xl font-bold text-center mb-12">Udogodnienia dla naszych gosci</h2>

    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
      {#each amenities as amenity}
        <div class="p-6 bg-white rounded-lg border border-gray-200 hover:border-primary-500 transition-all text-center">
          <!-- Icon with enhanced glow effect -->
          <div class="relative mx-auto mb-4 w-16 h-16 flex items-center justify-center">
            <div
              class="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(59,130,246,0.15)_0%,transparent_60%)] backdrop-blur-sm"
            ></div>
            <div
              class="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(59,130,246,0.15)_10%,transparent_70%)]"
            ></div>
            <svelte:component this={amenity.icon} class="w-10 h-10 text-primary-500 relative z-10" />
          </div>

          <h3 class="text-lg font-semibold text-gray-800 mb-2">
            {amenity.title}
          </h3>
          <p class="text-sm text-gray-600 hidden sm:block">
            {amenity.description}
          </p>
        </div>
      {/each}
    </div>
  </div>
</section>
