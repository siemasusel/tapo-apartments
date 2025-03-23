import { apartments } from './apartments/data';
import type { PageLoad } from './$types';

export const load: PageLoad = () => {
  return { apartments };
};
