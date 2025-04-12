<script lang="ts">
  // Import Svelte lifecycle functions and browser check
  import { onMount, onDestroy } from "svelte";
  import { browser } from "$app/environment";

  // --- Lightgallery imports (remain the same) ---
  import lightGallery from "lightgallery";
  import type { LightGallery } from "lightgallery/lightgallery";
  import "lightgallery/css/lightgallery.css";
  import "lightgallery/css/lg-zoom.css";
  import "lightgallery/css/lg-thumbnail.css";
  import lgThumbnail from "lightgallery/plugins/thumbnail";
  import lgZoom from "lightgallery/plugins/zoom";

  // --- Masonry/imagesLoaded imports are REMOVED ---

  export let slug: string;

  // --- Data fetching ---
  interface ImageMetadata {
    sources: { [key: string]: string };
    img: { src: string; w: number; h: number };
  }
  const allImages = import.meta.glob("/src/lib/assets/gallery/**/*.{jpg,png,webp}", {
    query: {
      enhanced: true,
      // Large (lightbox), Medium (grid image display)
      w: "1500;400", // Request 1500w for lightbox, 400w for grid image
      format: "webp",
    },
    eager: true,
  });
  let filteredImages: ImageMetadata[] = Object.entries(allImages ?? {})
    .filter(([path]) => {
      if (!slug) return false;
      return path.includes(`/gallery/${slug}/`);
    })
    .map(([, module]) => module.default as ImageMetadata);

  // --- Instance variables ---
  let lgInstance: LightGallery | null = null;
  // Masonry instance removed
  const galleryId = `lightgallery--${slug}`; // ID for lightGallery container

  onMount(() => {
    // Guard execution for browser environment only
    if (browser) {
      const element = document.getElementById(galleryId);
      if (element) {
        try {
          // Initialize lightGallery
          lgInstance = lightGallery(element, {
            plugins: [lgThumbnail, lgZoom],
            thumbnail: true,
            zoom: true,
            speed: 300,
            selector: "a",
            mode: "lg-fade",
            download: false,
            counter: true,
          });
        } catch (error) {
          console.error("Error initializing lightGallery:", error);
        }
      }
    }
  });

  onDestroy(() => {
    // Cleanup lightGallery instance
    if (lgInstance) {
      lgInstance.destroy();
    }
  });

  // --- Helper Functions ---
  // Gets the source for the image displayed in the grid (e.g., 400w)
  function getGridImageUrl(imgData: ImageMetadata): string {
    let gridImageUrl = imgData.img.src; // Fallback
    const webpSources = imgData.sources?.webp;
    if (webpSources) {
      const sourcesArray = webpSources.split(", ");
      // Find 400w source, fallback to main src if not found
      let entry = sourcesArray.find((s) => s.endsWith(" 400w"));
      if (entry) {
        gridImageUrl = entry.split(" ")[0];
      } else {
        // Fallback to the default src if specific size isn't in sources
        gridImageUrl = imgData.img.src;
      }
    }
    return gridImageUrl.startsWith("/") ? gridImageUrl : `/${gridImageUrl}`;
  }

  // Gets the source for the large image used in lightGallery
  function getMainSrc(imgData: ImageMetadata): string {
    // Assumes the default is the largest
    const mainSrc = imgData.img.src;
    return mainSrc.startsWith("/") ? mainSrc : `/${mainSrc}`;
  }
</script>

<div class="mb-4">
  {#if filteredImages.length > 0}
    <div class="flex flex-wrap items-start gap-2 justify-start" id={galleryId}>
      {#each filteredImages as imgData, i}
        {#if imgData?.img}
          {@const mainSrc = getMainSrc(imgData)}
          {@const gridImgSrc = getGridImageUrl(imgData)}
          <div class="image-container relative overflow-hidden rounded bg-gray-100 h-[200px] md:h-[240px]">
            <a href={mainSrc} class="block h-full">
              <img src={gridImgSrc} alt={"Zdjęcie " + (i + 1)} class="block h-full w-auto mx-auto" loading="lazy" />
            </a>
          </div>
        {/if}
      {/each}
    </div>
  {:else}
    <p>No images found for this gallery.</p>
  {/if}
</div>
