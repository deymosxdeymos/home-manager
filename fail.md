# Hyprland Debug Failures Log

## 2026-01-14: Black screen on SDDM login - Hyprland crash (SIGABRT)

### Symptom
- Black screen when selecting Hyprland session from SDDM
- Session starts then immediately exits
- `coredumpctl` shows multiple Hyprland crashes with SIGABRT

### Root Cause Analysis
1. **Crash stack trace** (from `coredumpctl info`):
   ```
   #12 throwError
   #13 CCompositor::initServer
   #14 main
   ```
   The crash happens during compositor initialization - Hyprland fails to initialize the GPU/DRM backend.

2. **Missing nixGL in PATH**: 
   - `start-hyprland` has built-in nixGL detection (`shouldUseNixGL`)
   - However, when SDDM launches the session, `~/.nix-profile/bin` may not be in PATH
   - `start-hyprland` can't find `nixGL` executable to wrap Hyprland

3. **Wrapper script issue**:
   - `~/.local/bin/hyprland-wrapper` directly calls `start-hyprland`
   - Does NOT source `~/.nix-profile/etc/profile.d/nix.sh` or add nix-profile to PATH
   - SDDM environment is minimal, doesn't include user's nix paths

### Evidence
- `strings start-hyprland | grep nixgl` shows: "requires nixGL", "will use nixGL"
- `start-hyprland --help` confirms `--no-nixgl` option exists
- Crash PID was using OLD Hyprland (2025-12-29), wrapper now points to newer version (2026-01-13)

### Fix
**Confirmed via Hyprland Wiki**: "Since 0.54, `start-hyprland` will automatically use `nixGL` if needed. For versions before that, you must use `nixGL start-hyprland`."

We're on **0.53.0**, but `start-hyprland` has its own nixGL detection that complains about `--impure` installation. 

**Solution**: Wrap with nixGL and disable internal detection:
```sh
nixGLIntel start-hyprland --no-nixgl
```

This gives:
- ✅ nixGL wrapping (GPU drivers work)
- ✅ start-hyprland features (watchdog, crash recovery)  
- ✅ No "impure" error

### Status
- [x] Fix applied
- [x] Tested with TTY (works, but warning without start-hyprland)
- [ ] Tested with start-hyprland --no-nixgl
- [ ] Tested with SDDM login
- [ ] Session runs successfully
