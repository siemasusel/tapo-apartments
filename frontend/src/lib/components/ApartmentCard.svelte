<script>
  export let apartment;
  export let isEven; // Prop to determine if the card is even or odd
</script>

<!-- Apartment Card Container -->
<div class={`grid grid-cols-2 ${isEven ? 'md:grid-cols-[3fr_4fr] ' : 'md:grid-cols-[4fr_3fr] '} w-full rounded-lg overflow-hidden`}>

  <!-- Image Section -->
  <div class={`flex overflow-hidden ${isEven ? 'md:order-2' : 'md:order-1'} h-full`}>
    <img
      src={apartment.image}
      alt={apartment.title}
      class="w-full h-full max-h-150 object-cover rounded-lg" 
    />
  </div>

  <!-- Information Section -->
  <div class={`p-6 flex flex-col justify-between ${isEven ? 'text-right md:order-1' : 'text-left md:order-2'}`}>
    <!-- Title -->
    <h2 class="text-2xl font-bold mb-4">{apartment.title}</h2>

    <!-- Icons Section -->
    <div class={`flex space-x-4 mb-4 ${isEven ? 'justify-end' : 'justify-start'}`}>
      <div class="flex items-center">
        <span class="text-gray-600">👤</span>
        <span class="ml-2">{apartment.capacity}</span>
      </div>
      <div class="flex items-center">
        <span class="text-gray-600">🛏️</span>
        <span class="ml-2">{apartment.beds.double} Double, {apartment.beds.single} Single, {apartment.beds.sofa} Sofa</span>
      </div>
    </div>

    <!-- Description -->
    <p class="text-gray-700 mb-4 text-justify">{apartment.description}</p>

    <!-- Price -->
    <div class="text-xl font-semibold mb-4">${apartment.price} / night</div>

    <!-- Buttons -->
    <div class="flex space-x-4">
      <button class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-300">Wiecej</button>
      <button class="bg-black text-white px-4 py-2 rounded hover:bg-gray-700">Zarezerwuj</button>
    </div>
  </div>
</div>
