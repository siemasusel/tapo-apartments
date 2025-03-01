<script>
  import Navbar from '$lib/components/Navbar.svelte';
  import Header from '$lib/components/Header.svelte';
  import Amenities from '$lib/components/Amenities.svelte';
  import ContactInfo from '$lib/components/ContactInfo.svelte';
  import ApartmentCard from '$lib/components/ApartmentCard.svelte';
  import Footer from '$lib/components/Footer.svelte';
  import Contact from '$lib/components/Contact.svelte';

  import olaMainImage from '$lib/assets/ola-main.jpg'
  import aniaMainImage from '$lib/assets/ania-main.jpg'

  // Example apartment data
  const apartments = [
    {
      image: olaMainImage,
      title: 'Apartment Ola',
      capacity: '2 Guests',
      beds: {
        double: 1,
        single: 0,
        sofa: 1
      },
      description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages.',
      price: 360
    },
    {
      image: aniaMainImage,
      title: 'Apartment Ania',
      capacity: '4 Guests',
      beds: {
        double: 2,
        single: 0,
        sofa: 0
      },
      description: 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.',
      price: 420
    }
  ];
</script>

<main class="min-h-screen flex flex-col bg-white pt-32 -mt-32">
  <Navbar />
  <Header />

  <div class="container mx-auto px-4 py-8">
    <h1 class="text-2xl text-center font-bold mb-8">Nasze apartamenty</h1>
    <div class="space-y-8">
      {#each apartments as apartment, index}
        <ApartmentCard {apartment} isEven={index % 2 === 1} />
      {/each}
    </div>
  </div>

  <Footer />
</main>