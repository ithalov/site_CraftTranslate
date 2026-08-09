type BrandLogoProps = {
  className?: string;
  showWordmark?: boolean;
};

export function BrandLogo({ className, showWordmark = true }: BrandLogoProps) {
  const logoSrc = `${import.meta.env.BASE_URL}logo.png`;

  return (
    <img
      src={logoSrc}
      alt="CraftTranslate"
      className={className}
      data-wordmark={showWordmark ? 'true' : 'false'}
    />
  );
}
