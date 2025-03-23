<!-- src/lib/ApartmentListing.svelte -->
<script lang="ts">
  export let apartment;

  import { Users, BedDouble, BedSingle, Sofa } from "lucide-svelte";
</script>

<a
  href={`/apartments/${apartment.slug}`}
  class="block group relative h-96 w-full overflow-hidden rounded-xl shadow-lg transition-all duration-300 hover:shadow-xl"
>
  <!-- Darkened Image Overlay -->
  <div class="absolute inset-0 bg-black/40 z-10 rounded-xl" />

  <!-- Apartment Image -->
  <img
    src={apartment.image}
    alt={apartment.title}
    class="absolute inset-0 h-full w-full object-cover rounded-xl transition-transform duration-500 group-hover:scale-105"
  />

  <!-- Content Overlay -->
  <div class="absolute inset-0 z-20 flex flex-col items-center p-6 text-white">
    <!-- Centered Title -->
    <h2 class="text-3xl font-bold mb-4 text-center drop-shadow-lg">{apartment.title}</h2>

    <!-- Icons Container (original positioning) -->
    <div class="mt-auto w-full flex justify-between items-center">
      <div class="flex flex-wrap items-center gap-4">
        <!-- Capacity -->
        <div class="flex items-center space-x-2 bg-white/10 backdrop-blur-sm px-4 py-2 rounded-full">
          <Users class="w-5 h-5" />
          <span class="font-medium">{apartment.capacity}</span>
        </div>

        <!-- Beds -->
        {#if apartment.beds.double > 0}
          <div class="flex items-center space-x-2 bg-white/10 backdrop-blur-sm px-4 py-2 rounded-full">
            <BedDouble class="w-5 h-5" />
            <span class="font-medium">{apartment.beds.double}</span>
          </div>
        {/if}

        {#if apartment.beds.single > 0}
          <div class="flex items-center space-x-2 bg-white/10 backdrop-blur-sm px-4 py-2 rounded-full">
            <BedSingle class="w-5 h-5" />
            <span class="font-medium">{apartment.beds.single}</span>
          </div>
        {/if}

        {#if apartment.beds.sofa > 0}
          <div class="flex items-center space-x-2 bg-white/10 backdrop-blur-sm px-4 py-2 rounded-full">
            <Sofa class="w-5 h-5" />
            <span class="font-medium">{apartment.beds.sofa}</span>
          </div>
        {/if}
      </div>

      <!-- Price -->
      <div class="bg-white/10 backdrop-blur-sm px-4 py-2 rounded-full">
        <span class="font-bold text-lg">{apartment.price} zł</span>
        <span class="font-medium text-sm"> / noc</span>
      </div>
    </div>
  </div>
</a>

<style>
  /* Smooth transitions for all properties */
  a {
    transition:
      transform 0.3s ease,
      box-shadow 0.3s ease;
  }

  /* Small scale effect on hover */
  a:hover {
    transform: translateY(-2px);
  }
</style>
