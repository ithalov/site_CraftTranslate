type BrandLogoProps = {
  className?: string;
  showWordmark?: boolean;
};

export function BrandLogo({ className, showWordmark = true }: BrandLogoProps) {
  return (
    <img
      src="/logo.png"
      alt="CraftTranslate"
      className={className}
      data-wordmark={showWordmark ? 'true' : 'false'}
    />
  );
}
