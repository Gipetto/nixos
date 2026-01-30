{ pkgs, lib, ... }: {
  # Inject a user.js file in to all firefox profiles
  # Since we're not managing firefox with Nix, we can't do it the nice way
  home.activation.injectFirefoxUserJs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    userjs_source="${./user.js}"
    
    # Detect platform and set profile glob
    case "$(uname -s)" in
      Darwin)
        profile_glob="$HOME/Library/Application Support/Firefox/Profiles/*default-release-*"
        ;;
      Linux)
        profile_glob="$HOME/.mozilla/firefox/*default*"
        ;;
      *)
        echo "⚠ Unsupported platform: $(uname -s)"
        exit 0
        ;;
    esac
    
    # Inject into all matching profiles
    found=0
    for profile_dir in $profile_glob; do
      # Skip if glob didn't match anything
      [ -e "$profile_dir" ] || continue
      
      # Skip non-directories
      [ -d "$profile_dir" ] || continue
      
      # Inject user.js symlink
      mkdir -p "$profile_dir" 2>/dev/null || true
      ln -sf "$userjs_source" "$profile_dir/user.js"
      echo "✓ Injected user.js into $profile_dir"
      found=1
    done
    
    if [ $found -eq 0 ]; then
      echo "ℹ No Firefox profiles found (will inject on first launch)"
      echo "  Searched: $profile_glob"
    fi
  '';
}
