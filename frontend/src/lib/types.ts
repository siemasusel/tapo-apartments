import { type Icon as IconType } from '@lucide/svelte';
import type { IconNode } from 'lucide-svelte';
import type { DateValue } from "@internationalized/date";

export interface BedConfiguration {
  double: number;
  single: number;
  sofa: number;
}

export interface Amenity {
  icon?: typeof IconType;
  iconNode?: IconNode;
  title: string;
}

export interface PriceSpan {
  startDate: DateValue;
  endDate: DateValue;
  price: number;
}

export interface Apartment {
  slug: string;
  title: string;
  capacity: number;
  beds: BedConfiguration;
  description: string;
  basePrice: number;
  priceSpans?: PriceSpan[];
  amenities: Amenity[];
}

export interface ContactInformation {
  address: Address;
  phone: string;
  email: string;
}

export interface Address {
  street: string;
  zip: string;
  city: string;
}
