import type { Apartment } from '../types';
import { isWithinInterval, toDate } from 'date-fns'; // Or use @internationalized/date's comparison functions
import { getLocalTimeZone, type DateValue } from "@internationalized/date"; // Import getLocalTimeZone and DateValue

export function getApartmentPriceForDate(apartment: Apartment, date: DateValue): number {
  const selectedDate = toDate(date.toDate(getLocalTimeZone())); // Convert DateValue to standard Date for date-fns

  // 1. Check if the date falls within any defined price spans
  if (apartment.priceSpans) {
    for (const span of apartment.priceSpans) {
      const spanStartDate = toDate(span.startDate.toDate(getLocalTimeZone()));
      const spanEndDate = toDate(span.endDate.toDate(getLocalTimeZone()));

      // Check if the selected date falls within the span (inclusive)
      if (isWithinInterval(selectedDate, { start: spanStartDate, end: spanEndDate })) {
        return span.price; // Return the specific price for this span
      }
    }
  }

  // 2. If no specific price span applies, return the base price
  return apartment.basePrice;
}

// The calculateTotalPrice function remains largely the same, but it will now always
// get a price back from getPriceForDate (either a span price or the base price).
export function calculateTotalPrice(apartment: Apartment, checkInDate: DateValue, checkOutDate: DateValue): number {
  let totalPrice = 0;
  let currentDate = toDate(checkInDate.toDate(getLocalTimeZone()));
  const endDate = toDate(checkOutDate.toDate(getLocalTimeZone()));

  // Ensure check-out is after check-in
  if (currentDate >= endDate) {
    return 0;
  }

  while (currentDate < endDate) {
    // getPriceForDate will now always return a number, no need for undefined check
    const priceForDay = getPriceForDate(apartment, new (checkInDate as any).constructor(currentDate, getLocalTimeZone()));
    totalPrice += priceForDay;
    currentDate.setDate(currentDate.getDate() + 1); // Move to the next day
  }
  return totalPrice;
}
