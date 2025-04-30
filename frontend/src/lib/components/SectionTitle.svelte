<script>
  export let text;

  // Prop for the text size (e.g., '3xl', '4xl')
  // Defaults to '3xl'
  export let size = "3xl";

  // Construct the dynamic class string
  // Includes base styles and the dynamic text size
  const titleClasses = `text-${size} text-center font-bold mb-8 xl:mb-12`;
</script>

<h1 class={titleClasses}>
  {text}
</h1>
