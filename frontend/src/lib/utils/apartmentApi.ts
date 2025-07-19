import { CalendarDate, type DateValue } from "@internationalized/date";
import { ApartmentsApi } from "../generated/openapi-client";
import { Configuration, type UnavailableDateRange } from "../generated/openapi-client";

const api = new ApartmentsApi(new Configuration({
  basePath: "https://api.tapoapartamenty.pl/v1",
}));

/**
 * Helper function to convert a JavaScript Date object to a CalendarDate object.
 * @param date The JavaScript Date object to convert.
 * @returns A CalendarDate object.
 */
const toCalendarDate = (date: Date): CalendarDate => {
  return new CalendarDate(date.getFullYear(), date.getMonth() + 1, date.getDate());
};

/**
 * Helper function to add a range of CalendarDate objects to the allUnavailableDates array.
 * This function now directly takes CalendarDate objects.
 * @param startCalendarDate The start date of the range as a CalendarDate.
 * @param endCalendarDate The end date of the range as a CalendarDate.
 * @param allUnavailableDates The array to which the dates will be added.
 */
const addDateRange = (
  startCalendarDate: CalendarDate,
  endCalendarDate: CalendarDate,
  allUnavailableDates: DateValue[]
) => {
  let current = startCalendarDate;
  while (current.compare(endCalendarDate) <= 0) {
    allUnavailableDates.push(current);
    current = current.add({ days: 1 });
  }
};

/**
 * Fetches unavailable dates for a given apartment slug from the API
 * and processes them into an array of CalendarDate objects.
 * @param slug The slug of the apartment (e.g., "ola").
 * @returns A Promise that resolves to an array of DateValue (CalendarDate) objects.
 */
export async function fetchUnavailableDates(slug: string): Promise<DateValue[]> {
  try {
    const response = await api.apiApartmentsSlugAvailabilityGet({
      slug: slug,
    });

    const allUnavailableDates: DateValue[] = [];

    // Process external unavailable dates
    response.externalUnavailableDates?.forEach((range: UnavailableDateRange) => {
      if (range.startDate instanceof Date && range.endDate instanceof Date) {
        const startCalendarDate = toCalendarDate(range.startDate);
        const endCalendarDate = toCalendarDate(range.endDate);
        addDateRange(startCalendarDate, endCalendarDate, allUnavailableDates);
      } else {
        console.warn("Skipping invalid external unavailable date range:", range);
      }
    });

    // Process internal unavailable dates (if any)
    response.internalUnavailableDates?.forEach((range: UnavailableDateRange) => {
      if (range.startDate instanceof Date && range.endDate instanceof Date) {
        const startCalendarDate = toCalendarDate(range.startDate);
        const endCalendarDate = toCalendarDate(range.endDate);
        addDateRange(startCalendarDate, endCalendarDate, allUnavailableDates);
      } else {
        console.warn("Skipping invalid internal unavailable date range:", range);
      }
    });

    return allUnavailableDates;
  } catch (error) {
    console.error("Failed to fetch unavailable dates:", error);
    return [];
  }
}
