# home-manager/programs/firefox.nix
{ lib, ... }:
{
  home.activation.injectFirefoxUserJs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Firefox user.js comes from chezmoi at ~/firefox/user.js
    userjs_source="$HOME/firefox/user.js"
    
    if [ ! -f "$userjs_source" ]; then
      echo "ℹ️  Firefox user.js not found (will be provided by chezmoi)"
      exit 0
    fi
    
    # Detect platform and set profile glob
    case "$(uname -s)" in
      Darwin)
        profile_glob="$HOME/Library/Application Support/Firefox/Profiles/*default-release-*"
        ;;
      Linux)
        profile_glob="$HOME/.mozilla/firefox/*default*"
        ;;
    esac
    
    found=0
    for profile_dir in $profile_glob; do
      [ -e "$profile_dir" ] || continue
      [ -d "$profile_dir" ] || continue
      
      mkdir -p "$profile_dir" 2>/dev/null || true
      ln -sf "$userjs_source" "$profile_dir/user.js"
      echo "✓ Injected user.js into $profile_dir"
      found=1
    done
    
    if [ $found -eq 0 ]; then
      echo "ℹ️  No Firefox profiles found (will inject on first launch)"
    fi
  '';
}