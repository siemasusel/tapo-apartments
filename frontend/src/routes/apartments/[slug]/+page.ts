import { error } from '@sveltejs/kit';
import { apartments } from '../data';
import type { PageLoad } from './$types';

export const load: PageLoad = ({ params }) => {
  const apartment = apartments.find((a) => a.slug === params.slug);

  if (!apartment) error(404);

  return { apartment };
};
