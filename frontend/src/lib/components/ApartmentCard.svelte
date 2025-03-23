<script>
  export let apartment;
  export let isEven; // Prop to determine if the card is even or odd

  import { Users, BedDouble, BedSingle, Sofa } from "lucide-svelte";
</script>

<!-- Apartment Card Container -->
<div class="flex flex-col md:flex-row w-full overflow-hidden min-h-[400px]">
  <!-- Image Section (60% of the card) -->
  <div class={`w-full md:w-3/5 ${isEven ? "md:order-last" : "md:order-first"}`}>
    <img src={apartment.image} alt={apartment.title} class="w-full h-full object-cover rounded-xl" />
  </div>

  <!-- Information Section (40% of the card) -->
  <div class={`w-full md:w-2/5 px-8 flex flex-col ${isEven ? "text-right" : "text-left"}`}>
    <!-- Flex-grow for content to stay at the top -->
    <div class="flex-grow">
      <!-- Title -->
      <h2 class="text-2xl font-bold mb-4">{apartment.title}</h2>

      <!-- Icons Section -->
      <div class={`flex flex-wrap items-center gap-4 mb-6 ${isEven ? "justify-end" : "justify-start"}`}>
        <!-- Capacity -->
        <div class="flex items-center space-x-1">
          <span class="text-xl align-middle">{apartment.capacity}</span>
          <Users class="w-6 h-6 mt-0.5" />
        </div>

        <!-- Beds - Only show if count > 0 -->
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
        <button
          class="bg-primary text-white px-6 py-2 rounded-full hover:bg-blue-400 transition-colors duration-300 justify-self-end"
          >Wiecej</button
        >
        <button
          class="bg-black text-white px-6 py-2 rounded-full hover:bg-gray-700 transition-colors duration-300 justify-self-end"
          >Zarezerwuj</button
        >
      </div>
    </div>
  </div>
</div>
