import type { ContactInformation, Apartment } from "$lib/types";

export const siteUrl = "https://www.tapoapartamenty.pl";
export const siteName = "TAPO Apartamenty";

export function absoluteUrl(path: string): string {
  if (path.startsWith("http://") || path.startsWith("https://")) {
    return path;
  }

  return `${siteUrl}${path.startsWith("/") ? path : `/${path}`}`;
}

export function buildLodgingBusinessSchema(contact: ContactInformation, imageUrl: string) {
  return {
    "@context": "https://schema.org",
    "@type": "LodgingBusiness",
    name: siteName,
    url: siteUrl,
    image: [imageUrl],
    email: contact.email,
    telephone: contact.phone,
    address: {
      "@type": "PostalAddress",
      streetAddress: contact.address.street,
      addressLocality: contact.address.city,
      postalCode: contact.address.zip,
      addressCountry: "PL",
    },
    areaServed: {
      "@type": "City",
      name: "Krynica-Zdroj",
    },
  };
}

export function buildApartmentSchema(apartment: Apartment, imageUrl: string, url: string) {
  return {
    "@context": "https://schema.org",
    "@type": "Accommodation",
    name: apartment.title,
    url,
    image: [imageUrl],
    description: apartment.description,
    occupancy: {
      "@type": "QuantitativeValue",
      maxValue: apartment.capacity,
    },
    numberOfRooms: apartment.beds.double + apartment.beds.single + apartment.beds.sofa,
    amenityFeature: apartment.amenities.map((amenity) => ({
      "@type": "LocationFeatureSpecification",
      name: amenity.title,
      value: true,
    })),
    offers: {
      "@type": "Offer",
      priceCurrency: "PLN",
      price: apartment.basePrice,
      availability: "https://schema.org/InStock",
      url,
    },
  };
}

export function buildFaqSchema(
  questions: Array<{ question: string; answer: string; bulletpoints?: string[] }>,
) {
  return {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: questions.map((item) => ({
      "@type": "Question",
      name: item.question,
      acceptedAnswer: {
        "@type": "Answer",
        text: [item.answer, ...(item.bulletpoints ?? [])].join(" "),
      },
    })),
  };
}
