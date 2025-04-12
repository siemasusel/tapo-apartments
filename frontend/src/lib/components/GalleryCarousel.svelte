<script lang="ts">
  // Import Svelte lifecycle functions and browser check
  import { onMount, onDestroy } from "svelte";
  import { browser } from "$app/environment";

  // Splice imports
  import { Splide, SplideSlide } from "@splidejs/svelte-splide";
  import "@splidejs/svelte-splide/css";

  // --- Lightgallery imports (remain the same) ---
  import lightGallery from "lightgallery";
  import type { LightGallery } from "lightgallery/lightgallery";
  import "lightgallery/css/lightgallery.css";
  import "lightgallery/css/lg-zoom.css";
  import "lightgallery/css/lg-thumbnail.css";
  import lgThumbnail from "lightgallery/plugins/thumbnail";
  import lgZoom from "lightgallery/plugins/zoom";
  import { Maximize2 } from "lucide-svelte";

  export let slug: string;

  interface ImageMetadata {
    sources: { [key: string]: string };
    img: { src: string; w: number; h: number };
  }

  const allImages = import.meta.glob("/src/lib/assets/gallery/**/*.{jpg,png,webp}", {
    query: {
      enhanced: true,
      w: "1500;500",
      format: "webp",
    },
    eager: true,
  });

  let filteredImages: (ImageMetadata & { isVertical: boolean })[] = Object.entries(allImages ?? {})
    .filter(([path]) => {
      if (!slug) return false;
      return path.includes(`/gallery/${slug}/`);
    })
    .map(([, module]) => {
      const imgData = module.default as ImageMetadata;
      return {
        ...imgData,
        isVertical: imgData.img.h > imgData.img.w,
      };
    });

  const splideOptions = {
    rewind: true,
    perPage: 3,
    perMove: 1,
    gap: "0.7rem",
    arrows: true,
    // pagination: false,
    // height: "333px",
  };

  let lgInstance: LightGallery | null = null;
  const galleryId = `lightgallery--${slug}`; // Unique ID for the gallery container

  onDestroy(() => {
    // Cleanup lightGallery instance on component destruction
    if (browser && lgInstance) {
      // Add browser check here too for safety
      console.log("Destroying lightGallery instance"); // Optional: for debugging
      lgInstance.destroy();
      lgInstance = null; // Clear the reference
    }
  });

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

  // --- Helper Functions ---
  // Gets the source for the image displayed in the grid (e.g., 500w)
  function getGridImageUrl(imgData: ImageMetadata): string {
    let gridImageUrl = imgData.img.src; // Fallback
    const webpSources = imgData.sources?.webp;
    if (webpSources) {
      const sourcesArray = webpSources.split(", ");
      let entry = sourcesArray.find((s) => s.endsWith(" 500w"));

      if (entry) {
        gridImageUrl = entry.split(" ")[0];
      } else {
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

<Splide id={galleryId} options={splideOptions} aria-label="Zdjęcie dla apartamentu {slug}">
  {#each filteredImages as imgData, i}
    {@const mainSrc = getMainSrc(imgData)}
    {@const gridImgSrc = getGridImageUrl(imgData)}
    <SplideSlide class="h-80 flex justify-between">
      <a href={mainSrc} class="group relative block h-full">
        <div class="relative h-full w-full">
          <img
            src={gridImgSrc}
            alt={"Zdjęcie " + (i + 1)}
            class="block object-cover h-full w-full rounded-xl transition-all duration-300"
          />
          <!-- Hover overlay -->
          <div
            class="absolute inset-0 bg-black/20 opacity-0 transition-opacity duration-300 group-hover:opacity-100 rounded-xl"
          />
          <!-- Loop icon -->
          <div
            class="absolute inset-0 flex items-center justify-center opacity-0 transition-opacity duration-300 group-hover:opacity-100"
          >
            <!-- <Maximize2 class="w-8 h-8 text-gray-800 stroke-[1.5]" /> -->
            <div class="p-2 rounded-full bg-white/30 backdrop-blur-sm">
              <Maximize2 class="w-6 h-6 text-gray-900 stroke-[1.5]" />
            </div>
          </div>
        </div>
      </a>
    </SplideSlide>
  {/each}
</Splide>

<style>
  :global(.splide__arrow) {
    z-index: 10;
  }
</style>
