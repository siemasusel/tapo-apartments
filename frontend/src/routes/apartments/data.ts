import type { Apartment } from "$lib/types";
import { parseDate } from "@internationalized/date";

import { SquareParking, CookingPot, Wifi, TvMinimalPlay, ShowerHead, WashingMachine, Microwave, BookOpen } from "@lucide/svelte";
import { hairdryer } from "@lucide/lab";

export const apartments: Apartment[] = [
  {
    slug: "ola",
    title: "Apartment Ola",
    capacity: 4,
    beds: {
      double: 1,
      single: 0,
      sofa: 1,
    },
    description:
      "Apartment Ola to idealna propozycja odpoczynku dla par. W apartamencie czeka na Was stylowe wnętrze z akcentami folklorystycznymi, w pełni wyposażony aneks kuchenny z mikrofalówką i ekspresem kapsułkowym, rozkładana kanapa, telewizor z opcją Smart TV, przytulna sypialnia oraz łazienka z prysznicem. Proponujemy także wybór książek oraz gier, a także możliwość pozostawienia sprzętu narciarskiego w części wspólnej.",
    basePrice: 360,
    priceSpans: [
      { startDate: parseDate('2025-10-01'), endDate: parseDate('2026-02-28'), price: 450 }, // High season override
      { startDate: parseDate('2026-10-01'), endDate: parseDate('2027-02-28'), price: 450 }, // High season override
      { startDate: parseDate('2027-10-01'), endDate: parseDate('2028-02-29'), price: 450 }, // High season override
      { startDate: parseDate('2028-10-01'), endDate: parseDate('2029-02-28'), price: 450 }, // High season override
    ],
    amenities: [
      {
        icon: ShowerHead,
        title: "Prywatna łazienka z prysznicem",
      },
      {
        icon: CookingPot,
        title: "W pełni wyposażona kuchnia",
      },
      {
        icon: Microwave,
        title: "Mikrofalówka",
      },
      {
        icon: Wifi,
        title: "Darmowe WiFi",
      },
      {
        icon: TvMinimalPlay,
        title: "Smart TV",
      },
      {
        iconNode: hairdryer,
        title: "Suszarka",
      },
      {
        icon: WashingMachine,
        title: "Dostęp do pralki",
      },
      {
        icon: SquareParking,
        title: "Bezpłatny parking",
      },
      {
        icon: BookOpen,
        title: "Książki i gry planszowe",
      }
    ],
  },
  {
    slug: "ania",
    title: "Apartment Ania",
    capacity: 4,
    beds: {
      double: 1,
      single: 2,
      sofa: 0,
    },
    description:
      "Apartament Ania sprawdzi się dla rodzin, które cenią sobie przestronne i komfortowe wnętrza. W apartamencie znajduje się łóżko dwuosobowe oraz osobna sypialnia z dwoma łóżkami jednoosobowymi. Do Waszej dyspozycji znajduje się w pełni wyposażona kuchnia wraz z mikrofalówką, ekspresem kapsułkowym, dwoma biurkami, telewizorem z opcją Smart TV oraz łazienką z prysznicem. W części wspólnej znajduje się narciarnia oraz kącik z książkami i grami. ",
    basePrice: 400,
    priceSpans: [
      { startDate: parseDate('2025-10-01'), endDate: parseDate('2026-02-28'), price: 470 }, // High season override
      { startDate: parseDate('2026-10-01'), endDate: parseDate('2027-02-28'), price: 470 }, // High season override
      { startDate: parseDate('2027-10-01'), endDate: parseDate('2028-02-29'), price: 470 }, // High season override
      { startDate: parseDate('2028-10-01'), endDate: parseDate('2029-02-28'), price: 470 }, // High season override
    ],
    amenities: [
      {
        icon: ShowerHead,
        title: "Prywatna łazienka z prysznicem",
      },
      {
        icon: CookingPot,
        title: "W pełni wyposażona kuchnia",
      },
      {
        icon: Microwave,
        title: "Mikrofalówka",
      },
      {
        icon: Wifi,
        title: "Darmowe WiFi",
      },
      {
        icon: TvMinimalPlay,
        title: "Smart TV",
      },
      {
        iconNode: hairdryer,
        title: "Suszarka",
      },
      {
        icon: WashingMachine,
        title: "Dostęp do pralki",
      },
      {
        icon: SquareParking,
        title: "Bezpłatny parking",
      },
    ],
  },
];
