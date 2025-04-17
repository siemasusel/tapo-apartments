<script>
  import heroImage from "$lib/assets/hero-image.jpg?enhanced";
</script>

<!-- Hero Section -->
<section class="pt-5 pb-12">
  <div class="container mx-auto">
    <div class="relative rounded-xl shadow-xl overflow-hidden">
      <!-- Image with Overlay -->
      <div class="relative">
        <div class="absolute inset-0 bg-black/40 z-10"></div>
        <enhanced:img
          src="$lib/assets/hero-image.jpg?w=1440;768"
          sizes="(min-width:1440px) 1440px, (min-width:768px) 768px"
          alt="Apartamenty w Krynicy Zdrój"
          class="w-full h-[500px] lg:h-[700px] object-cover object-center"
        />

        <!-- Text Overlay -->
        <div class="absolute inset-0 z-20 flex flex-col items-center justify-center text-center p-4">
          <div class="max-w-2xl space-y-6">
            <h1 id="about" class="text-4xl lg:text-5xl font-bold text-white leading-tight drop-shadow-md">
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
