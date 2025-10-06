<script lang="ts">
  import type { Apartment } from "$lib/types";
  import { BedDouble, BedSingle, CookingPot, Info, ShowerHead, Sofa, Users } from "lucide-svelte";
  import GalleryCarousel from "./GalleryCarousel.svelte";
  import { Popover } from "bits-ui";
  import { getApartmentPriceForDate } from "$lib/utils/pricing";
  import { getLocalTimeZone, today } from "@internationalized/date";

  let { apartment }: { apartment: Apartment } = $props<{ apartment: Apartment }>();

  const { slug, beds, capacity } = apartment;

  const price = getApartmentPriceForDate(apartment, today(getLocalTimeZone()));
</script>

<div class="space-y-6 rounded-t-xl">
  <h1 class="text-4xl font-bold text-center pb-6 pt-12">{apartment.title}</h1>

  <GalleryCarousel {slug} />

  <div class="flex flex-col lg:flex-row gap-6 pb-6 items-center">
    <!-- Original icons container with hidden bathroom/kitchen on mobile -->
    <div class="w-full lg:w-[72%] flex flex-wrap justify-around sm:justify-evenly">
      <!-- Capacity -->
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

      <!-- Hidden on mobile -->
      <div class="text-center hidden sm:block">
        <div class="bg-gray-200 rounded-full p-3 mx-auto mb-2 w-fit">
          <ShowerHead class="size-6" />
        </div>
        <div>1</div>
        <div>Łazienka</div>
      </div>

      <div class="text-center hidden sm:block">
        <div class="bg-gray-200 rounded-full p-3 mx-auto mb-2 w-fit">
          <CookingPot class="size-6" />
        </div>
        <div>1</div>
        <div>Kuchnia</div>
      </div>
    </div>

    <!-- Mobile-only bathroom/kitchen row -->
    <!-- <div class="w-full flex sm:hidden justify-center gap-8"> -->
    <div class="w-full flex sm:hidden justify-evenly">
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

    <!-- Price box -->
    <div
      class="w-full lg:w-[28%] bg-primary-light p-6 rounded-xl flex flex-col justify-center items-center text-center mx-auto lg:mx-0 shadow-2xl"
    >
      <Popover.Root>
        <Popover.Trigger
          class="flex items-center gap-1 cursor-pointer text-3xl font-bold mb-2"
          aria-label="Informacja o cenie"
        >
          <span>{price} zł</span>
          <Info class="size-5 text-gray-800 hover:text-gray-900" />
        </Popover.Trigger>

        <Popover.Portal>
          <Popover.Content
            sideOffset={6}
            class="rounded-md border border-gray-200 bg-white shadow-lg p-3 text-xs text-gray-700 max-w-[240px] z-50"
          >
            Cena obowiązuje w dniu dzisiejszym i może różnić się w zależności od terminu rezerwacji. Poniżej znajduje
            się kalendarz z cenami za poszczególne dni.
          </Popover.Content>
        </Popover.Portal>
      </Popover.Root>

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
