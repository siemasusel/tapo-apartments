<script lang="ts">
  import type { Apartment } from "$lib/types";

  export let apartment: Apartment;
  export let isEven: boolean;

  import { Users, BedDouble, BedSingle, Sofa } from "lucide-svelte";

  const mainImages = import.meta.glob("/src/lib/assets/gallery/**/1.{jpg,png,webp}", {
    query: {
      enhanced: true,
      w: "900",
      format: "webp",
    },
    eager: true,
  });

  $: imageSrc = mainImages[`/src/lib/assets/gallery/${apartment.slug}/1.jpg`].default.img.src;
</script>

<!-- Apartment Card Container -->
<div class="flex flex-col md:flex-row w-full overflow-hidden min-h-[350px]">
  <!-- Image Section (60% of the card) -->
  <div class={`w-full md:w-3/5 ${isEven ? "md:order-last" : "md:order-first"}`}>
    <img src={imageSrc} alt={apartment.title} class="w-full h-full object-cover rounded-xl" />
  </div>

  <!-- Information Section (40% of the card) -->
  <div class={`w-full md:w-2/5 px-8 flex flex-col ${isEven ? "text-right" : "text-left"}`}>
    <!-- Flex-grow for content to stay at the top -->
    <div class="flex-grow">
      <!-- Title -->
      <h2 class="text-2xl font-bold mb-4">{apartment.title}</h2>

      <!-- Icons Section -->
      <div class={`flex flex-wrap items-center gap-4 mb-6 ${isEven ? "justify-end" : "justify-start"}`}>
        <div class="flex items-center space-x-1">
          <span class="text-xl align-middle">{apartment.capacity}</span>
          <Users class="w-6 h-6 mt-0.5" />
        </div>

        <div class="flex items-center gap-4">
          {#if apartment.beds.double > 0}
            <div class="flex items-center space-x-1">
              <span class="text-xl">{apartment.beds.double}</span>
              <BedDouble class="w-6 h-6 mt-0.5" />
            </div>
          {/if}

          {#if apartment.beds.single > 0}
            <div class="flex items-center space-x-1">
              <span class="text-xl">{apartment.beds.single}</span>
              <BedSingle class="w-6 h-6 mt-0.5" />
            </div>
          {/if}

          {#if apartment.beds.sofa > 0}
            <div class="flex items-center space-x-1">
              <span class="text-xl">{apartment.beds.sofa}</span>
              <Sofa class="w-6 h-6 mt-0.5" />
            </div>
          {/if}
        </div>
      </div>

      <!-- Description -->
      <p class="text-gray-700 mb-4 text-justify">{apartment.description}</p>

      <!-- Price -->
      <!-- <div class="text-xl font-semibold">{apartment.price} zł / noc</div> -->
      <div class="text-xl font-semibold">
        <span>{apartment.price} zł</span>
        <span class="text-base"> / noc</span>
      </div>
    </div>

    <!-- Buttons align to the bottom and right if isEven -->
    <div class={`mt-4 flex space-x-4 ${isEven ? "justify-end" : "justify-start"}`}>
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
