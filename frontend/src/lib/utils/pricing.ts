import type { Apartment } from "../types";
import { isWithinInterval, toDate } from "date-fns";
import { CalendarDate, getLocalTimeZone, type DateValue } from "@internationalized/date";

export function getApartmentPriceForDate(apartment: Apartment, date: DateValue): number {
  const selectedDate = toDate(date.toDate(getLocalTimeZone()));

  // 1. Check if the date falls within any defined price spans
  if (apartment.priceSpans) {
    for (const span of apartment.priceSpans) {
      const spanStartDate = toDate(span.startDate.toDate(getLocalTimeZone()));
      const spanEndDate = toDate(span.endDate.toDate(getLocalTimeZone()));

      // Check if the selected date falls within the span (inclusive)
      if (isWithinInterval(selectedDate, { start: spanStartDate, end: spanEndDate })) {
        return span.price;
      }
    }
  }

  return apartment.basePrice;
}

export function calculateTotalPrice(apartment: Apartment, checkInDate: DateValue, checkOutDate: DateValue): number {
  let totalPrice = 0;
  let currentDate = toDate(checkInDate.toDate(getLocalTimeZone()));
  const endDate = toDate(checkOutDate.toDate(getLocalTimeZone()));

  // Ensure check-out is after check-in
  if (currentDate >= endDate) {
    return 0;
  }

  while (currentDate < endDate) {
    const currentCalendarDate = new CalendarDate(
      currentDate.getFullYear(),
      currentDate.getMonth() + 1,
      currentDate.getDate(),
    );
    const priceForDay = getApartmentPriceForDate(apartment, currentCalendarDate);
    totalPrice += priceForDay;
    currentDate.setDate(currentDate.getDate() + 1);
  }

  return totalPrice;
}
