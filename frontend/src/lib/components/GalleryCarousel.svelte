<script lang="ts">
  import { onMount } from "svelte";

  import { Maximize2 } from "lucide-svelte";
  // Splide imports
  import { Splide, SplideSlide, type Options } from "@splidejs/svelte-splide";
  import "@splidejs/svelte-splide/css";
  // PhotoSwite imports
  import PhotoSwipeLightbox from "photoswipe/lightbox";
  import "photoswipe/style.css";

  export let slug: string;

  interface ImageMetadata {
    sources: { [key: string]: string };
    img: { src: string; w: number; h: number };
  }

  const allImages = import.meta.glob("/src/lib/assets/gallery/**/*.{jpg,png,webp}", {
    query: {
      enhanced: true,
      w: "1800;600",
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

  const splideOptions: Options = {
    rewind: true,
    perPage: 3,
    perMove: 1,
    gap: "0.7rem",
    arrows: true,
    breakpoints: {
      1280: {
        perPage: 2,
        gap: "0.5rem",
      },
      768: {
        perPage: 1,
      },
    },
    padding: "none",
    // pagination: false,
    // height: "333px",
  };

  const galleryId = `photoswipe--${slug}`; // Unique ID for the gallery container

  onMount(() => {
    let lightbox = new PhotoSwipeLightbox({
      gallery: "#" + galleryId,
      children: "a",
      showHideAnimationType: "fade",
      showAnimationDuration: 250,
      hideAnimationDuration: 250,
      // padding: { top: 20, bottom: 20, left: 20, right: 20 },
      pswpModule: () => import("photoswipe"),
    });
    lightbox.init();
  });

  // --- Helper Functions ---
  // Gets the source for the image displayed in the grid (e.g., 600w)
  function getGridImageUrl(imgData: ImageMetadata): string {
    let gridImageUrl = imgData.img.src; // Fallback
    const webpSources = imgData.sources?.webp;
    if (webpSources) {
      const sourcesArray = webpSources.split(", ");
      let entry = sourcesArray.find((s) => s.endsWith(" 600w"));

      if (entry) {
        gridImageUrl = entry.split(" ")[0];
      } else {
        gridImageUrl = imgData.img.src;
      }
    }
    return gridImageUrl;
  }

  // Gets the source for the large image used in lightGallery
  function getMainSrc(imgData: ImageMetadata): string {
    // Assumes the default is the largest
    return imgData.img.src;
  }
</script>

<Splide id={galleryId} class="pswp-gallery" options={splideOptions} aria-label="Zdjęcie dla apartamentu {slug}">
  {#each filteredImages as imgData, i}
    {@const mainSrc = getMainSrc(imgData)}
    {@const gridImgSrc = getGridImageUrl(imgData)}
    <SplideSlide class="h-[350px] flex justify-center">
      <a
        href={mainSrc}
        data-pswp-width={imgData.img.w}
        data-pswp-height={imgData.img.h}
        target="_blank"
        rel="noreferrer"
        class="group relative block h-full"
      >
        <!-- <a href={mainSrc} class="group relative block h-full"> -->
        <div class="relative h-full w-full">
          <img
            src={gridImgSrc}
            alt={"Zdjęcie " + (i + 1)}
            class="block object-cover h-full w-full rounded-xl transition-all duration-300"
          />
          <!-- Hover overlay -->
          <div
            class="absolute inset-0 bg-black/20 opacity-0 transition-opacity duration-300 group-hover:opacity-100 rounded-xl"
          ></div>
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
