<script lang="ts">
  import { Calendar } from "bits-ui";
  import { getLocalTimeZone, today, type DateValue } from "@internationalized/date";
  import { ChevronLeft, ChevronRight } from "@lucide/svelte";
  import { onMount } from "svelte";
  import { fetchUnavailableDates } from "$lib/utils/apartmentApi";
  import { getApartmentPriceForDate } from "$lib/utils/pricing";
  import { Skeleton } from "./ui/skeleton";
  import type { Apartment } from "$lib/types";
  import { swipe, type SwipeCustomEvent } from "svelte-gestures";

  let unavailableDates: Array<DateValue> = $state([]);
  let isLoading = $state(true);
  let isError = $state(false);

  let { apartment }: { apartment: Apartment } = $props();

  let numberOfMonths = $state(2);

  // Add gestures
  let nextButton = $state<HTMLButtonElement | null>(null);
  let prevButton = $state<HTMLButtonElement | null>(null);

  const handleSwipe = (event: SwipeCustomEvent) => {
    const { direction } = event.detail;

    if (direction === "left" && nextButton && !nextButton.disabled) {
      nextButton.click();
    } else if (direction === "right" && prevButton && !prevButton.disabled) {
      prevButton.click();
    }
  };

  // Load unavailable dates and update number of months
  onMount(() => {
    const updateNumberOfMonths = () => {
      numberOfMonths = window.matchMedia("(max-width: 640px)").matches ? 1 : 2;
    };

    updateNumberOfMonths();
    window.addEventListener("resize", updateNumberOfMonths);

    // Call the async data fetching function immediately
    const loadDates = async () => {
      try {
        isLoading = true;
        unavailableDates = await fetchUnavailableDates(apartment.slug);
      } catch (e) {
        isError = true;
        console.error("Failed to fetch unavailable dates:", e);
      } finally {
        isLoading = false;
      }
    };

    loadDates(); // Execute the async function

    // Return the cleanup function directly from the synchronous onMount
    return () => {
      window.removeEventListener("resize", updateNumberOfMonths);
    };
  });

  // Helper functions for dates
  function isDateUnavailable(date: DateValue) {
    return unavailableDates.some((d) => d.compare(date) === 0);
  }

  function isDateDisabled(date: DateValue) {
    return date.compare(todayDate) < 0 || date.compare(maxDate) > 0;
  }

  function getPriceForDate(date: DateValue): string | null {
    // If the date is in the unavailableDates array, return a dash
    if (isDateUnavailable(date) || isDateDisabled(date)) {
      return "-";
    }

    return getApartmentPriceForDate(apartment, date).toString(); // Default price for available dates
  }

  // Set today date and max date
  const todayDate = today(getLocalTimeZone());
  const maxDate = todayDate.add({ months: 12 }).subtract({ days: todayDate.day });

  let value = $state(todayDate);
</script>

<div class="flex w-full rounded-lg">
  {#if isLoading}
    <div class="flex flex-col w-full space-y-2">
      <Skeleton class="h-[55px] w-full rounded-[15px]" />
      <div class="flex w-full space-x-2">
        <Skeleton class="h-[320px] w-full rounded-[15px]" />
        <Skeleton class="h-[320px] w-full rounded-[15px] max-sm:hidden" />
      </div>
    </div>
  {:else if isError}
    <p class="text-red-500">Problem z wczytaniem kalendarza - spróbuj ponownie za chwilę.</p>
  {:else}
    {#key numberOfMonths}
      <div
        use:swipe={() => ({ timeframe: 500, minSwipeDistance: 60, touchAction: "pan-y" })}
        onswipe={handleSwipe}
        class="flex w-full rounded-lg"
      >
        <Calendar.Root
          class="rounded-[15px] border border-gray-200 bg-white p-4 shadow-md w-full"
          weekdayFormat="short"
          minValue={todayDate}
          maxValue={maxDate}
          type="single"
          locale="pl-PL"
          {numberOfMonths}
          {isDateUnavailable}
          bind:value
          readonly
        >
          {#snippet children({ months, weekdays })}
            <Calendar.Header class="flex items-center justify-between">
              <Calendar.PrevButton
                bind:ref={prevButton}
                class="inline-flex data-disabled:text-gray-200 data-disabled:hover:bg-inherit size-10 items-center justify-center rounded-[9px] bg-white hover:bg-gray-100 active:scale-[0.98] active:transition-all"
              >
                <ChevronLeft class="size-6" />
              </Calendar.PrevButton>
              <Calendar.Heading class="font-medium text-gray-900" />

              <Calendar.NextButton
                bind:ref={nextButton}
                class="inline-flex data-disabled:text-gray-200 data-disabled:hover:bg-inherit size-10 items-center justify-center rounded-[9px] bg-white hover:bg-gray-100 active:scale-[0.98] active:transition-all"
              >
                <ChevronRight class="size-6" />
              </Calendar.NextButton>
            </Calendar.Header>

            <div class="flex flex-col space-y-4 pt-4 sm:flex-row sm:space-x-4 sm:space-y-0 flex-1">
              {#each months as month, i (i)}
                <Calendar.Grid class="w-full select-none space-y-1 border-collapse">
                  <Calendar.GridHead>
                    <Calendar.GridRow class="mb-1 grid grid-cols-7 gap-1">
                      {#each weekdays as day}
                        <Calendar.HeadCell class="text-center text-xs font-normal text-gray-400">
                          {day.slice(0, 2)}
                        </Calendar.HeadCell>
                      {/each}
                    </Calendar.GridRow>
                  </Calendar.GridHead>

                  <Calendar.GridBody>
                    {#each month.weeks as week}
                      <Calendar.GridRow class="grid grid-cols-7 gap-1">
                        {#each week as date}
                          <Calendar.Cell {date} month={month.value}>
                            {@const isCurrentlyDisabled = isDateDisabled(date)}
                            {@const isCurrentlyOutsideMonth =
                              date.month !== month.value.month || date.year !== month.value.year}
                            {@const isCurrentlyUnavailable = isDateUnavailable(date)}

                            <Calendar.Day class="flex flex-col items-center justify-center h-14 w-10 group">
                              <span
                                class={`
                                text-gray-800
                                group-data-[today]:font-medium
                                group-data-[disabled]:pointer-events-none
                                group-data-[disabled]:text-gray-100
                                group-data-[disabled]:no-underline
                                group-data-[outside-month]:text-transparent
                                group-data-[outside-month]:no-underline
                                ${isCurrentlyUnavailable ? "line-through text-red-300" : ""}
                                ${isCurrentlyDisabled && isCurrentlyUnavailable ? "text-gray-100 no-underline" : ""}
                                ${isCurrentlyOutsideMonth && isCurrentlyUnavailable ? "text-transparent no-underline" : ""}
                              `}
                              >
                                {date.day}
                              </span>
                              {@const price = getPriceForDate(date)}
                              <span
                                class={`text-xs
                                text-gray-400
                                group-data-[disabled]:text-gray-100
                                group-data-[outside-month]:text-transparent
                                ${isCurrentlyOutsideMonth && isCurrentlyUnavailable ? "text-transparent" : ""}
                                ${isCurrentlyDisabled && isCurrentlyUnavailable ? "text-gray-100" : ""}
                              `}
                              >
                                {price}
                              </span>
                            </Calendar.Day>
                          </Calendar.Cell>
                        {/each}
                      </Calendar.GridRow>
                    {/each}
                  </Calendar.GridBody>
                </Calendar.Grid>
              {/each}
            </div>
          {/snippet}
        </Calendar.Root>
      </div>
    {/key}
  {/if}
</div>
