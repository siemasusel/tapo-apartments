<script lang="ts">
  import type { Apartment } from "$lib/types";
  import { Icon } from "@lucide/svelte";
  import FaqSection from "./FAQSection.svelte";
  let { apartment } = $props<{ apartment: Apartment }>();

  const half = Math.ceil(apartment.amenities.length / 2);
  const leftColumn = apartment.amenities.slice(0, half);
  const rightColumn = apartment.amenities.slice(half);
</script>

<div class="space-y-12 py-12">
  <!-- Description Section -->
  <section>
    <h2 class="text-3xl font-semibold mb-8">Opis</h2>
    <p class="leading-relaxed">{@html apartment.description}</p>
  </section>

  <hr class="border-t-2 border-gray-200" />

  <!-- Amenities Section -->
  <section>
    <h2 class="text-3xl font-semibold mb-8">Udogodnienia</h2>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-x-12 gap-y-6">
      <div class="space-y-6">
        {#each leftColumn as amenity}
          {@const IconComponent = amenity.icon}
          {@const iconNode = amenity.iconNode}
          <div class="flex items-center space-x-3">
            {#if iconNode}
              <Icon {iconNode} class="w-8 h-8" />
            {:else if IconComponent}
              <IconComponent class="w-8 h-8" />
            {/if}
            <span>{amenity.title}</span>
          </div>
        {/each}
      </div>

      <div class="space-y-6">
        {#each rightColumn as amenity}
          {@const IconComponent = amenity.icon}
          {@const iconNode = amenity.iconNode}
          <div class="flex items-center space-x-3">
            {#if iconNode}
              <Icon {iconNode} class="w-8 h-8" />
            {:else if IconComponent}
              <IconComponent class="w-8 h-8" />
            {/if}
            <span>{amenity.title}</span>
          </div>
        {/each}
      </div>
    </div>
  </section>

  <hr class="border-t-2 border-gray-200" />

  <section>
    <h2 class="text-3xl font-semibold mb-8">Dodatkowe informacje</h2>

    <FaqSection />
  </section>
</div>
