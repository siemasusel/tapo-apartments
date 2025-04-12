import type { Icon } from "lucide-svelte";

export interface BedConfiguration {
  double: number;
  single: number;
  sofa: number;
}

export interface Amenity {
  icon: typeof Icon;
  title: string;
}

export interface Apartment {
  image: string;
  slug: string;
  title: string;
  capacity: number;
  beds: BedConfiguration;
  description: string;
  price: number;
  amenities: Amenity[];
}
