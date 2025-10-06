<script lang="ts">
  import type { Apartment } from "$lib/types";
  import { getApartmentPriceForDate } from "$lib/utils/pricing";
  import { getLocalTimeZone, today } from "@internationalized/date";

  export let apartment: Apartment;
  export let isEven: boolean;

  import { Popover } from "bits-ui";

  import { Users, BedDouble, BedSingle, Sofa, Info } from "lucide-svelte";

  const images = import.meta.glob("/src/lib/assets/gallery/**/1.jpg", {
    query: {
      enhanced: true,
      w: "900",
      format: "webp",
    },
    eager: true,
  });

  $: imagePath = images[`/src/lib/assets/gallery/${apartment.slug}/1.jpg`].default.img.src as string;

  const price = getApartmentPriceForDate(apartment, today(getLocalTimeZone()));
</script>

<!-- Apartment Card Container -->
<div class="flex flex-col lg:flex-row w-full overflow-hidden min-h-[350px]">
  <!-- Image Section (60% of the card) -->
  <div class={`w-full lg:w-3/5 ${isEven ? "lg:order-last" : "lg:order-first"}`}>
    <img src={imagePath} alt={apartment.title} class="w-full h-full object-cover rounded-t-xl lg:rounded-xl" />
  </div>

  <!-- Information Section (40% of the card) -->
  <div
    class={`bg-grey xl:bg-inherit rounded-b-xl lg:rounded-none w-full lg:w-2/5 p-6 pb-8 lg:px-8 lg:py-0 flex flex-col text-center ${isEven ? "lg:text-right" : "lg:text-left"}`}
  >
    <!-- Flex-grow for content to stay at the top -->
    <div class="flex-grow">
      <!-- Title -->
      <h2 class="text-2xl font-bold mb-4">{apartment.title}</h2>

      <!-- Icons Section -->
      <div
        class={`flex flex-wrap items-center gap-4 mb-6 justify-center ${isEven ? "lg:justify-end" : "lg:justify-start"}`}
      >
        <div class="flex items-center space-x-1">
          <span class="text-xl align-middle">{apartment.capacity}</span>
          <Users class="size-6 mt-0.5" />
        </div>

        <div class="flex items-center gap-4">
          {#if apartment.beds.double > 0}
            <div class="flex items-center space-x-1">
              <span class="text-xl">{apartment.beds.double}</span>
              <BedDouble class="size-6 mt-0.5" />
            </div>
          {/if}

          {#if apartment.beds.single > 0}
            <div class="flex items-center space-x-1">
              <span class="text-xl">{apartment.beds.single}</span>
              <BedSingle class="size-6 mt-0.5" />
            </div>
          {/if}

          {#if apartment.beds.sofa > 0}
            <div class="flex items-center space-x-1">
              <span class="text-xl">{apartment.beds.sofa}</span>
              <Sofa class="size-6 mt-0.5" />
            </div>
          {/if}
        </div>
      </div>

      <!-- Description -->
      <p class="text-gray-700 mb-4 text-justify">{apartment.description}</p>

      <!-- Price -->
      <div class={`w-full flex justify-center ${isEven ? "lg:justify-end" : "lg:justify-start"}`}>
        <Popover.Root>
          <Popover.Trigger
            class="flex items-center gap-1 cursor-pointer text-xl font-semibold"
            aria-label="Informacja o cenie"
          >
            <span>{price} zł</span>
            <span class="text-base"> / noc</span>
            <Info class="size-4 text-gray-500 hover:text-gray-700" />
          </Popover.Trigger>

          <Popover.Portal>
            <Popover.Content
              sideOffset={6}
              class="rounded-md border border-gray-200 bg-white shadow-lg p-3 text-xs text-gray-700 max-w-[240px] z-50"
            >
              Cena obowiązuje w dniu dzisiejszym i może różnić się w zależności od terminu rezerwacji.
            </Popover.Content>
          </Popover.Portal>
        </Popover.Root>
      </div>
    </div>

    <!-- Buttons align to the bottom and right if isEven -->
    <div class={`mt-4 flex space-x-4 justify-center ${isEven ? "lg:justify-end" : "lg:justify-start"}`}>
      <div class="flex space-x-4">
        <a
          href="/apartments/{apartment.slug}"
          class="bg-primary text-white px-6 py-2 rounded-full hover:bg-primary-dark transition-colors duration-300 justify-self-end"
        >
          Więcej
        </a>
        <a
          href="/reservation"
          class="bg-black text-white px-6 py-2 rounded-full hover:bg-gray-800 transition-colors duration-300 justify-self-end"
        >
          Zarezerwuj
        </a>
      </div>
    </div>
  </div>
</div>
