import adapter from '@sveltejs/adapter-static';
import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';

/** @type {import('@sveltejs/kit').Config} */
const config = {
  preprocess: vitePreprocess(),

  kit: {
    // This site is deployed as prerendered static HTML behind CloudFront.
    // Do not reintroduce adapter-static fallback:'index.html', or public routes
    // will collapse back into an SPA shell and lose route-specific SEO metadata.
    prerender: {
      origin: 'https://www.tapoapartamenty.pl'
    },
    adapter: adapter({
      pages: 'build',
      assets: 'build',
      precompress: false,
      strict: true
    })
  }
};

export default config;
