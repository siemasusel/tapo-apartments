import type { Handle } from "@sveltejs/kit";
import { faqData } from "$lib/data/faq";
import { buildApartmentSchema, buildFaqSchema, buildLodgingBusinessSchema, siteUrl } from "$lib/seo";
import { apartments } from "./routes/apartments/data";
import { contactInformation } from "./routes/data";

function buildSchemaMarkup(pathname: string): string {
  const normalizedPath = pathname === "/" ? "/" : pathname.replace(/\/$/, "");

  if (normalizedPath === "/") {
    const schema = buildLodgingBusinessSchema(contactInformation, `${siteUrl}/images/og-main.jpg`);
    return `<script type="application/ld+json">${JSON.stringify(schema)}</script>`;
  }

  const apartmentMatch = normalizedPath.match(/^\/apartments\/([^/]+)$/);
  if (apartmentMatch) {
    const slug = apartmentMatch[1];
    const apartment = apartments.find((item) => item.slug === slug);
    if (!apartment) return "";

    const apartmentSchema = buildApartmentSchema(
      apartment,
      `${siteUrl}/images/og-${apartment.slug}.jpg`,
      `${siteUrl}${normalizedPath}`,
    );
    const faqSchema = buildFaqSchema(faqData);

    return [
      `<script type="application/ld+json">${JSON.stringify(apartmentSchema)}</script>`,
      `<script type="application/ld+json">${JSON.stringify(faqSchema)}</script>`,
    ].join("");
  }

  return "";
}

export const handle: Handle = async ({ event, resolve }) => {
  return resolve(event, {
    transformPageChunk: ({ html, done }) => {
      if (!done) return html;

      const schemaMarkup = buildSchemaMarkup(event.url.pathname);
      if (!schemaMarkup) return html;

      return html.replace("</head>", `${schemaMarkup}</head>`);
    },
  });
};
