import { CalendarDate, type DateValue } from "@internationalized/date";
import { ApartmentsApi } from "../generated/openapi-client";
import { Configuration } from "../generated/openapi-client";

const api = new ApartmentsApi(new Configuration({
  basePath: "https://api.tapoapartamenty.pl/v1",
}));

type RawUnavailableDateRange = {
  startDate: string;
  endDate: string;
};

type RawAvailabilityResponse = {
  externalUnavailableDates?: RawUnavailableDateRange[];
  internalUnavailableDates?: RawUnavailableDateRange[];
};

const parseCalendarDate = (value: string): CalendarDate | null => {
  const match = /^(\d{4})-(\d{2})-(\d{2})$/.exec(value);
  if (!match) return null;

  const [, year, month, day] = match;
  return new CalendarDate(Number(year), Number(month), Number(day));
};

const addDateRange = (startCalendarDate: CalendarDate, endCalendarDate: CalendarDate, allUnavailableDates: DateValue[]) => {
  let current = startCalendarDate;
  while (current.compare(endCalendarDate) <= 0) {
    allUnavailableDates.push(current);
    current = current.add({ days: 1 });
  }
};

export async function fetchUnavailableDates(slug: string): Promise<DateValue[]> {
  try {
    const response = await api.apiApartmentsSlugAvailabilityGetRaw({
      slug: slug,
    });
    const availability = await response.raw.json() as RawAvailabilityResponse;

    const allUnavailableDates: DateValue[] = [];

    const appendRanges = (ranges: RawUnavailableDateRange[] | undefined) => {
      ranges?.forEach((range) => {
        const startCalendarDate = parseCalendarDate(range.startDate);
        const endCalendarDate = parseCalendarDate(range.endDate);
        if (startCalendarDate && endCalendarDate) {
          addDateRange(startCalendarDate, endCalendarDate, allUnavailableDates);
        } else {
          console.warn("Skipping invalid unavailable date range:", range);
        }
      });
    };

    appendRanges(availability.externalUnavailableDates);
    appendRanges(availability.internalUnavailableDates);

    return allUnavailableDates;
  } catch (error) {
    console.error("Failed to fetch unavailable dates:", error);
    return [];
  }
}
