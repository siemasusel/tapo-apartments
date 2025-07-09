import type { RequestHandler } from '@sveltejs/kit';

export const prerender = true;

import mainImage from '$lib/assets/hero-image.jpg?enhanced';

import olaMainImage from '$lib/assets/gallery/ola/1.jpg?enhanced';
import olaKitchenImage from '$lib/assets/gallery/ola/3.jpg?enhanced';
import olaBedroomImage from '$lib/assets/gallery/ola/5.jpg?enhanced';
import olaBathroomImage from '$lib/assets/gallery/ola/8.jpg?enhanced';

import aniaMainImage from '$lib/assets/gallery/ania/1.jpg?enhanced';
import aniaKitchenImage from '$lib/assets/gallery/ania/4.jpg?enhanced';
import aniaBedroomImage from '$lib/assets/gallery/ania/6.jpg?enhanced';
import aniaBathroomImage from '$lib/assets/gallery/ania/8.jpg?enhanced';

export const GET: RequestHandler = async () => {
  const headers = {
    'Content-Type': 'application/xml',
    'Cache-Control': 'max-age=0, s-maxage=3600' // Cache for 1 hour
  };

  const baseUrl = 'https://www.tapoapartamenty.pl';
  const currentDate = '2025-06-23'; // Use the current date for lastmod

  const sitemapContent = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">

    <url>
        <loc>${baseUrl}/</loc>
        <lastmod>${currentDate}</lastmod>
        <changefreq>weekly</changefreq>
        <priority>1.0</priority>
        <image:image>
            <image:loc>${baseUrl}${mainImage.img.src}</image:loc>
            <image:caption>Główne zdjęcie strony Tapo Apartamenty - Widok na budynek</image:caption>
        </image:image>
    </url>

    <url>
        <loc>${baseUrl}/apartments</loc>
        <lastmod>${currentDate}</lastmod>
        <changefreq>daily</changefreq>
        <priority>0.5</priority>
    </url>

    <url>
        <loc>${baseUrl}/apartments/ola</loc>
        <lastmod>${currentDate}</lastmod>
        <changefreq>daily</changefreq>
        <priority>0.9</priority>
        <image:image>
            <image:loc>${baseUrl}${olaMainImage.img.src}</image:loc>
            <image:caption>Główne zdjęcie Apartamentu OLA w Krynicy-Zdroju</image:caption>
        </image:image>
        <image:image>
            <image:loc>${baseUrl}${olaBedroomImage.img.src}</image:loc>
            <image:caption>Sypialnia w Apartamencie OLA</image:caption>
        </image:image>
        <image:image>
            <image:loc>${baseUrl}${olaKitchenImage.img.src}</image:loc>
            <image:caption>Aneks kuchenny w Apartamencie OLA</image:caption>
        </image:image>
        <image:image>
            <image:loc>${baseUrl}${olaBathroomImage.img.src}</image:loc>
            <image:caption>Łazienka w Apartamencie OLA</image:caption>
        </image:image>
        </url>

    <url>
        <loc>${baseUrl}/apartments/ania</loc>
        <lastmod>${currentDate}</lastmod>
        <changefreq>daily</changefreq>
        <priority>0.9</priority>
        <image:image>
            <image:loc>${baseUrl}${aniaMainImage.img.src}</image:loc>
            <image:caption>Główne zdjęcie Apartamentu ANIA w Krynicy-Zdroju</image:caption>
        </image:image>
        <image:image>
            <image:loc>${baseUrl}${aniaBedroomImage.img.src}</image:loc>
            <image:caption>Sypialnia dwuosobowa w Apartamencie ANIA</image:caption>
        </image:image>
        <image:image>
            <image:loc>${baseUrl}${aniaKitchenImage.img.src}</image:loc>
            <image:caption>Aneks kuchenny w Apartamencie ANIA</image:caption>
        </image:image>
        <image:image>
            <image:loc>${baseUrl}${aniaBathroomImage.img.src}</image:loc>
            <image:caption>Łazienka w Apartamencie ANIA</image:caption>
        </image:image>
        </url>

</urlset>`;

  return new Response(sitemapContent.trim(), { headers });
};
