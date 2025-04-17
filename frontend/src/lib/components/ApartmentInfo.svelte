<script lang="ts">
  import type { Apartment } from "$lib/types";
  import { Icon } from "@lucide/svelte";
  import { hairdryer } from "@lucide/lab";
  let { apartment } = $props<{ apartment: Apartment }>();
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
    <div class="grid grid-cols-1 md:grid-cols-2 gap-y-6">
      {#each apartment.amenities as amenity}
        {@const IconComponent = amenity.icon}
        {@const iconNode = amenity.iconNode}
        <div class="flex items-center space-x-3">
          {#if iconNode}
            <Icon iconNode={hairdryer} class="w-8 h-8" />
          {:else if IconComponent}
            <IconComponent class="w-8 h-8" />
          {/if}
          <span>{amenity.title}</span>
        </div>
      {/each}
    </div>
  </section>
</div>
