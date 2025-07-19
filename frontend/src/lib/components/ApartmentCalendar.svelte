<script lang="ts">
  import { Calendar } from "bits-ui";
  import { getLocalTimeZone, today, type DateValue } from "@internationalized/date";
  import { ChevronLeft, ChevronRight } from "@lucide/svelte";
  import { onMount } from "svelte";
  import { fetchUnavailableDates } from "$lib/utils/apartmentApi";

  let unavailableDates: Array<DateValue> = $state([]);
  let isLoading = $state(true);
  let error: string | null = $state(null);

  let { slug }: { slug: string } = $props();

  let numberOfMonths = $state(2);

  onMount(() => {
    // <--- Make onMount synchronous here
    const updateNumberOfMonths = () => {
      numberOfMonths = window.matchMedia("(max-width: 640px)").matches ? 1 : 2;
    };

    updateNumberOfMonths();
    window.addEventListener("resize", updateNumberOfMonths);

    // Call the async data fetching function immediately
    const loadDates = async () => {
      try {
        isLoading = true;
        unavailableDates = await fetchUnavailableDates(slug);
      } catch (e) {
        console.error("Failed to fetch unavailable dates:", e);
        error = "Failed to load unavailable dates. Please try again.";
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

  const todayDate = today(getLocalTimeZone());
  const maxDate = todayDate.add({ months: 9 }).subtract({ days: todayDate.day });

  function isDateUnavailable(date: DateValue) {
    return unavailableDates.some((d) => d.compare(date) === 0);
  }

  let value = $state(todayDate);
</script>

<div class="flex w-full rounded-lg my-8">
  {#if isLoading}
    <p>Loading unavailable dates...</p>
  {:else if error}
    <p class="text-red-500">{error}</p>
  {:else}
    {#key numberOfMonths}
      <Calendar.Root
        class="rounded-[15px] border border-gray-200 bg-white p-4 shadow-md"
        weekdayFormat="narrow"
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
              class="inline-flex data-disabled:text-gray-200 data-disabled:hover:bg-inherit size-10 items-center justify-center rounded-[9px] bg-white hover:bg-gray-100 active:scale-[0.98] active:transition-all"
            >
              <ChevronLeft class="size-6" />
            </Calendar.PrevButton>
            <Calendar.Heading class="text-[15px] font-medium text-gray-900" />
            <Calendar.NextButton
              class="inline-flex data-disabled:text-gray-200 data-disabled:hover:bg-inherit size-10 items-center justify-center rounded-[9px] bg-white hover:bg-gray-100 active:scale-[0.98] active:transition-all"
            >
              <ChevronRight class="size-6" />
            </Calendar.NextButton>
          </Calendar.Header>

          <div class="flex flex-col space-y-4 pt-4 sm:flex-row sm:space-x-4 sm:space-y-0">
            {#each months as month, i (i)}
              <Calendar.Grid class="w-full select-none space-y-1 border-collapse">
                <Calendar.GridHead>
                  <Calendar.GridRow class="mb-1 flex w-full justify-between">
                    {#each weekdays as day, i (i)}
                      <Calendar.HeadCell class="w-10 rounded-md text-xs font-normal text-gray-400">
                        <div>{day.slice(0, 2)}</div>
                      </Calendar.HeadCell>
                    {/each}
                  </Calendar.GridRow>
                </Calendar.GridHead>

                <Calendar.GridBody>
                  {#each month.weeks as weekDates, i (i)}
                    <Calendar.GridRow class="flex w-full">
                      {#each weekDates as date, i (i)}
                        <Calendar.Cell
                          {date}
                          month={month.value}
                          class="relative size-10 p-0 text-center text-sm pointer-events-none"
                        >
                          <Calendar.Day
                            class="group relative inline-flex size-10 items-center justify-center whitespace-nowrap rounded-[9px] p-0 text-sm font-normal
                            text-gray-800
                            data-today:font-medium
                            data-disabled:pointer-events-none
                            data-disabled:text-gray-100
                            data-disabled:no-underline
                            data-unavailable:line-through
                            data-unavailable:text-red-300
                            data-outside-month:text-gray-100
                            data-outside-month:no-underline

                            [&[data-outside-month][data-unavailable]]:text-gray-100
                            [&[data-outside-month][data-unavailable]]:no-underline
                            [&[data-disabled][data-unavailable]]:text-gray-100
                            [&[data-disabled][data-unavailable]]:no-underline
                            "
                          >
                            <div
                              class="bg-black group-data-today:block absolute top-[5px] hidden size-1 rounded-full"
                            ></div>
                            {date.day}
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
    {/key}
  {/if}
</div>
