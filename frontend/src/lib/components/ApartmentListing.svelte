<script lang="ts">
  import type { Apartment } from "$lib/types";
  import { getApartmentPriceForDate } from "$lib/utils/pricing";
  import { getLocalTimeZone, today } from "@internationalized/date";

  let { apartment }: { apartment: Apartment } = $props<{ apartment: Apartment }>();

  import { Users, BedDouble, BedSingle, Sofa, type Icon as IconType } from "@lucide/svelte";

  type ImageModule = {
    default: {
      img: {
        src: string;
      };
    };
  };

  const images = import.meta.glob("/src/lib/assets/gallery/**/1.jpg", {
    query: {
      enhanced: true,
      w: "900",
      format: "webp",
    },
    eager: true,
  }) as Record<string, ImageModule>;

  const imageKey = `/src/lib/assets/gallery/${apartment.slug}/1.jpg`;
  const imageModule = images[imageKey];
  const imagePath = $derived(imageModule?.default.img.src ?? "");

  const price = getApartmentPriceForDate(apartment, today(getLocalTimeZone()));
</script>

{#snippet IconInfo(Icon: typeof IconType, value: string | number)}
  <div class="flex items-center space-x-2 bg-white/10 backdrop-blur-sm px-4 py-2 rounded-full">
    <Icon class="size-5" />
    <span class="font-medium">{value}</span>
  </div>
{/snippet}

<a
  href={`/apartments/${apartment.slug}`}
  class="
    block group relative h-96 w-full overflow-hidden rounded-xl shadow-lg
    transition-shadow duration-300 ease-in-out hover:shadow-xl
    "
>
  <div class="absolute inset-0 bg-black/40 z-10 rounded-xl"></div>

  <img
    src={imagePath}
    alt={apartment.title}
    class="absolute inset-0 h-full w-full object-cover rounded-xl transition-transform duration-500 group-hover:scale-105"
  />

  <div class="absolute inset-0 z-20 flex flex-col items-center p-6 text-white">
    <h2 class="text-3xl font-bold mb-4 text-center drop-shadow-lg">{apartment.title}</h2>

    <div class="mt-auto w-full flex justify-between items-end">
      <div class="flex flex-wrap flex-col sm:flex-row gap-4">
        {@render IconInfo(Users, apartment.capacity)}

        {#if apartment.beds.double > 0}
          {@render IconInfo(BedDouble, apartment.beds.double)}
        {/if}

        {#if apartment.beds.single > 0}
          {@render IconInfo(BedSingle, apartment.beds.single)}
        {/if}

        {#if apartment.beds.sofa > 0}
          {@render IconInfo(Sofa, apartment.beds.sofa)}
        {/if}
      </div>

      <div class="bg-white/10 backdrop-blur-sm px-4 py-2 rounded-full">
        <span class="font-bold text-lg">{price} zł</span>
        <span class="font-medium text-sm"> / noc</span>
      </div>
    </div>
  </div>
</a>
