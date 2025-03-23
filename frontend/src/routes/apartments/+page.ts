import { apartments } from './data';
import type { PageLoad } from './$types';

export const load: PageLoad = () => {
  return { apartments };
};
