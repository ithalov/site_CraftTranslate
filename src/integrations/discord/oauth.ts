import { env } from '@/services/environment';

function base64UrlEncode(bytes: Uint8Array) {
  let binary = '';

  for (const byte of bytes) {
    binary += String.fromCharCode(byte);
  }

  return btoa(binary).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/g, '');
}

async function sha256(value: string) {
  const data = new TextEncoder().encode(value);
  const digest = await crypto.subtle.digest('SHA-256', data);
  return new Uint8Array(digest);
}

export async function createDiscordPkcePair() {
  const verifier = base64UrlEncode(crypto.getRandomValues(new Uint8Array(32)));
  const challenge = base64UrlEncode(await sha256(verifier));

  return { verifier, challenge };
}

export function createDiscordAuthorizeUrl(state: string, codeChallenge: string) {
  const params = new URLSearchParams({
    client_id: env.discordClientId,
    redirect_uri: env.discordRedirectUri,
    response_type: 'code',
    scope: 'identify email',
    state,
    code_challenge: codeChallenge,
    code_challenge_method: 'S256'
  });

  return `https://discord.com/api/oauth2/authorize?${params.toString()}`;
}
