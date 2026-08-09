export function slugifyProfileHandle(value: string) {
  return value
    .normalize('NFKD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

export function buildPublicProfileHandle(
  username: string | null | undefined,
  displayName: string | null | undefined,
  userId: string
) {
  const candidate = username?.trim() || displayName?.trim() || '';

  if (candidate) {
    return slugifyProfileHandle(candidate);
  }

  return `user-${userId.slice(0, 8)}`;
}
