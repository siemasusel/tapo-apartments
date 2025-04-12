<script>
  import heroImage from "$lib/assets/hero-image.jpg";
</script>

<!-- Hero Section -->
<section class="relative bg-white pt-5 pb-12">
  <div class="container mx-auto">
    <div class="relative rounded-xl shadow-xl overflow-hidden">
      <!-- Image with Overlay -->
      <div class="relative">
        <div class="absolute inset-0 bg-black/40 z-10"></div>
        <img
          src={heroImage}
          alt="Apartamenty w Krynicy Zdrój"
          class="w-full h-[600px] lg:h-[700px] object-cover object-center"
        />

        <!-- Text Overlay -->
        <div class="absolute inset-0 z-20 flex flex-col items-center justify-center text-center p-4">
          <div class="max-w-2xl space-y-6">
            <h1 class="text-4xl lg:text-5xl font-bold text-white leading-tight drop-shadow-md">
              Odpocznij w Krynicy Zdrój
            </h1>
            <p class="text-lg lg:text-xl text-white/90 lg:px-8 drop-shadow">
              Lorem ipsum dolor sit amet consectetur adipisicing elit. Architecto quas placeat voluptatem ratione.
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
