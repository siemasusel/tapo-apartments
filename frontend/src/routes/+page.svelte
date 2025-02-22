<script>
  import Navbar from '$lib/components/Navbar.svelte';
  import Header from '$lib/components/Header.svelte';
  import ApartmentCard from '$lib/components/ApartmentCard.svelte';
  import Footer from '$lib/components/Footer.svelte';

  // Example data for featured apartments
  const featuredApartments = [
    {
      image: 'https://picsum.photos/seed/picsum/200/300',
      title: 'Luxury Apartment',
      description: '3 Bedrooms, 2 Bathrooms',
      price: '$1,500/month',
      link: '/apartments/1'
    },
    {
      image: 'https://picsum.photos/seed/picsum/200/300',
      title: 'Cozy Studio',
      description: '1 Bedroom, 1 Bathroom',
      price: '$900/month',
      link: '/apartments/2'
    },
    {
      image: 'https://picsum.photos/seed/picsum/200/300',
      title: 'Modern Loft',
      description: '2 Bedrooms, 1 Bathroom',
      price: '$1,200/month',
      link: '/apartments/3'
    },
    {
      image: 'https://picsum.photos/seed/picsum/200/300',
      title: 'Modern Loft',
      description: '2 Bedrooms, 1 Bathroom',
      price: '$1,200/month',
      link: '/apartments/3'
    },
    {
      image: 'https://picsum.photos/seed/picsum/200/300',
      title: 'Modern Loft',
      description: '2 Bedrooms, 1 Bathroom',
      price: '$1,200/month',
      link: '/apartments/3'
    },
    {
      image: 'https://picsum.photos/seed/picsum/200/300',
      title: 'Modern Loft',
      description: '2 Bedrooms, 1 Bathroom',
      price: '$1,200/month',
      link: '/apartments/3'
    },
    {
      image: 'https://picsum.photos/seed/picsum/200/300',
      title: 'Modern Loft',
      description: '2 Bedrooms, 1 Bathroom',
      price: '$1,200/month',
      link: '/apartments/3'
    }
  ];
</script>

<main class="min-h-screen flex flex-col">
  <Navbar />
  <Header />

  <!-- Main Content -->
  <section class="flex-grow container mx-auto p-8">
    <h2 class="text-2xl font-bold mb-6">Featured Apartments</h2>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      {#each featuredApartments as apartment}
        <ApartmentCard {apartment} />
      {/each}
    </div>
  </section>

  <Footer />
</main>