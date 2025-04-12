<script lang="ts">
  import type { Apartment } from "$lib/types";
  import { BedDouble, BedSingle, CookingPot, ShowerHead, Sofa, Users } from "lucide-svelte";
  import GalleryCarousel from "./GalleryCarousel.svelte";

  let { apartment } = $props<{ apartment: Apartment }>();
  const { slug, beds, capacity } = apartment;
</script>

<div class="space-y-6 rounded-t-xl">
  <h1 class="text-4xl font-bold text-center pb-6 pt-12">{apartment.title}</h1>

  <GalleryCarousel {slug} />

  <div class="flex flex-col md:flex-row gap-6 pb-6 items-center">
    <div class="w-full md:w-[72%] flex flex-wrap items-center justify-evenly">
      <div class="text-center">
        <div class="bg-gray-200 rounded-full p-3 mx-auto mb-2 w-fit">
          <Users class="size-6" />
        </div>
        <div>{capacity}</div>
        <div>Osoby</div>
      </div>

      {#if beds.double > 0}
        <div class="text-center">
          <div class="bg-gray-200 rounded-full p-3 mx-auto mb-2 w-fit">
            <BedDouble class="size-6" />
          </div>
          <div>{beds.double}</div>
          <div>Łóżko podwójne</div>
        </div>
      {/if}

      {#if beds.single > 0}
        <div class="text-center">
          <div class="bg-gray-200 rounded-full p-3 mx-auto mb-2 w-fit">
            <BedSingle class="size-6" />
          </div>
          <div>{beds.single}</div>
          <div>Łóżka pojedyncze</div>
        </div>
      {/if}

      {#if beds.sofa > 0}
        <div class="text-center">
          <div class="bg-gray-200 rounded-full p-3 mx-auto mb-2 w-fit">
            <Sofa class="size-6" />
          </div>
          <div>{beds.sofa}</div>
          <div>Sofa</div>
        </div>
      {/if}

      <div class="text-center">
        <div class="bg-gray-200 rounded-full p-3 mx-auto mb-2 w-fit">
          <ShowerHead class="size-6" />
        </div>
        <div>1</div>
        <div>Łazienka</div>
      </div>

      <div class="text-center">
        <div class="bg-gray-200 rounded-full p-3 mx-auto mb-2 w-fit">
          <CookingPot class="size-6" />
        </div>
        <div>1</div>
        <div>Kuchnia</div>
      </div>
    </div>

    <div
      class="w-full md:w-[28%] bg-primary-light p-6 rounded-xl border border-primary-light flex flex-col justify-center items-center text-center mx-auto md:mx-0"
    >
      <div class="text-3xl font-bold mb-2">{apartment.price} zł</div>
      <div class="mb-4">za dobę</div>
      <a
        href="/reservation"
        class="bg-black text-white px-8 py-3 rounded-full hover:bg-gray-800 transition-colors duration-300 block text-center"
      >
        Zarezerwuj teraz
      </a>
    </div>
  </div>
</div>
