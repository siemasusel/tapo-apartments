import olaMainImage from "$lib/assets/ola-main.jpg";
import aniaMainImage from "$lib/assets/ania-main.jpg";
import type { Apartment } from "$lib/types";

import { SquareParking, CookingPot, Wifi, TvMinimalPlay, ShowerHead, WashingMachine, Refrigerator, Microwave } from "lucide-svelte";

export const apartments: Apartment[] = [
  {
    image: olaMainImage,
    slug: "ola",
    title: "Apartment Ola",
    capacity: 4,
    beds: {
      double: 1,
      single: 0,
      sofa: 1,
    },
    description:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages.",
    price: 360,
    amenities: [
      {
        icon: ShowerHead,
        title: "Prywatna lazienka z prysznicem",
      },
      {
        icon: CookingPot,
        title: "Aneks kuchenny",
      },
      {
        icon: Microwave,
        title: "Mikrofalowka",
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
        icon: WashingMachine,
        title: "Dostep do pralki",
      },
      {
        icon: SquareParking,
        title: "Bezplatny parking",
      },
    ],
  },
  {
    image: aniaMainImage,
    slug: "ania",
    title: "Apartment Ania",
    capacity: 4,
    beds: {
      double: 1,
      single: 2,
      sofa: 0,
    },
    description:
      "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    price: 420,
    amenities: [
      {
        icon: ShowerHead,
        title: "Prywatna lazienka z prysznicem",
      },
      {
        icon: CookingPot,
        title: "Aneks kuchenny",
      },
      {
        icon: Microwave,
        title: "Mikrofalowka",
      },
      {
        icon: Wifi,
        title: "Darmowe WiFi",
      },
      {
        icon: TvMinimalPlay,
        title: "Telewizor ze SmartTV",
      },
      {
        icon: WashingMachine,
        title: "Dostep do pralki",
      },
      {
        icon: SquareParking,
        title: "Bezplatny parking",
      },
    ],
  },
];
