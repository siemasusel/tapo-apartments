<script>
    export let apartment;
  </script>
  
  <div class="bg-white shadow-lg rounded-lg overflow-hidden">
    <img src={apartment.image} alt="Apartment" class="w-full h-48 object-cover" />
    <div class="p-6">
      <h3 class="text-xl font-semibold mb-2">{apartment.title}</h3>
      <p class="text-gray-600">{apartment.description}</p>
      <p class="text-gray-800 font-bold mt-4">{apartment.price}</p>
      <a href={apartment.link} class="mt-4 inline-block bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-500">View Details</a>
    </div>
</div>