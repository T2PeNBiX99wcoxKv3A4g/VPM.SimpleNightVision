# Changelog

## [unreleased]

### ⛰️  Features

- Add MASK_ON keyword and new shader parameters for improved UI customization - ([1c8e2bc](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/1c8e2bc3303b53c6c8469cc61b2779a1d5a6f1aa))
- Add UI overlay and digit rendering functionality to night vision shader - ([fd5d721](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/fd5d721b9ec24ec8e03a33683d14f3d7f8c07f21))
- Add advanced night vision effects and customizable shader parameters - ([0cfce81](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/0cfce81e512f9b17d72110d6ac57c369ecae5304))

### 🚜 Refactor

- Relocate NightVision.prefab to Prefabs folder for better asset organization - ([c2477fa](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/c2477fa6710d295c81f3844336deb3108be50a65))
- Restructure shader and asset folder hierarchy for better organization - ([44c2252](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/44c2252bd0c083210bb861baa06a52dc64a4f865))
- Use `const` qualifiers for better readability and optimization in shader functions - ([0f5d043](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/0f5d043d6b82668673a09b91a843321a563baccf))

### 🧪 Testing

- Add new Test scene with default lighting, camera, and basic objects - ([9fa80af](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/9fa80af54c94af4c076743b77fdaf47bd107163c))

### ⚙️ Miscellaneous Tasks

- Bump package version to 0.2.4 - ([fa62d36](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/fa62d36a329013d0d45b59cbe7df28f77d46870b))
- Update `release.yml` with new actions versions, changelog generation, and release process enhancements - ([7b57b1b](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/7b57b1b5d15be246776e5aa94725ae20d6ae86ca))
- Bump package version to 0.2.3 and update package metadata for Unity 2022.3 compatibility - ([66134a7](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/66134a70b513084acd5fca05ffe14b8c984bf98d))
- Bump package version to 0.2.2 - ([7209c9b](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/7209c9bd458d96dc4818d7e44231963eb57fa2a9))
- Update NightVision controller with new Gamma adjustment, DarknessCompensation, and OutlineSharpness values; set default controllers - ([c52fe68](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/c52fe68cd08959d02b0934c6647f4a190c5b27e7))
- Bump package version to 0.2.1 - ([4a73464](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/4a734641b580357d1182d8493ff019a51c95a5a1))
- Use saturate on finalEnv in NightVision shader to prevent overflow - ([4ae89c2](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/4ae89c212c184f5327e1ef857a644c849badf1ec))
- Bump package version to 0.2.0 - ([1fd45e4](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/1fd45e4429d1a12ddde14b9cd61ce120e128af51))
- Add Gamma adjustment feature with new animations, prefab updates, and NightVision material changes - ([d934ac6](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/d934ac64c922fd0695ce69e2f764fad97f8d08f1))
- Rename _Gamma_Adjust to _Gamma in NightVision shader for consistency - ([25bbdc1](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/25bbdc10d6ab5d75cd5fd98ec075713605268afb))
- Add Gamma adjustment and refine NightVision depth and outline calculations - ([0340d33](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/0340d33e41f79b5d22eef7da41122aaaf760351d))
- Add lilToon, asset-previewer, and unity-shaders dependencies; include lilToon default settings - ([e968e24](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/e968e2432312b595a35558bfff5a08f7e799322a))
- Update NightVision prefab default value for Animator's defaultValue setting - ([1d84411](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/1d844111966bdb451273022b211e7c2492834473))
- Bump package version to 0.1.9 - ([3263135](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/3263135073f29cdb3c0bcc7aacacf9d33831dad3))
- Update NightVision prefab default value for Animator setting - ([764d0fc](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/764d0fc465bceda666976f1197b42a9890d63af1))
- Bump package version to 0.1.8 - ([9977b3b](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/9977b3bcfffcc2051554992f1823953b7fc31768))
- Add new NightVision parameters (ScanSpeed, ScanWidth, Vignette settings); update BrightnessGain and DarknessCompensation defaults - ([7d20de9](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/7d20de9189757a43fc7fdc4e2f564ecf9b2063bc))
- Bump package version to 0.1.7 - ([a387c16](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/a387c168a7e469b9c55ff777637857a2755f4576))
- Add new textures and animations for NightVision parameters, including outline sharpness, scan speed, and scan width adjustments - ([9019957](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/90199570792733f415b343ce706ab2713b8f5379))
- Replace BrightNessBoost and MinVisibilityThreshold animations with BrightnessGain and DarknessCompensation equivalents - ([e4605fd](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/e4605fd99918e8e022d5c29395ec0283cdf0f573))
- Update Test scene and material with SCAN_ON keyword, tweak brightness, and add scan parameters - ([c4c09e9](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/c4c09e9c4c40857913e562669c79a7a71332a29c))
- Update NightVision prefab and material defaults; add SCAN_ON keyword and refine scan parameters - ([d7cedd9](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/d7cedd9aba7bfc98c0af89f64ac41339aa1beee9))
- Add scanning and vignette enhancements to shader; update defaults for brightness and depth blending - ([82901eb](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/82901ebac7f9c06ce334706bb26418e2661e1adb))
- Adjust default values for NightVision prefab parameters - ([6b1348b](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/6b1348b12e789752502572c9db4bda05f1b3b946))
- Bump package version to 0.1.6 - ([fc7ad35](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/fc7ad3505a711db9d19ab6677e1a64aeabbf268e))
- Add "Reset" GameObject with associated Transform and MonoBehaviour to NightVision prefab - ([f98a896](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/f98a8961622d049d141a872e543de833747736b1))
- Bump package version to 0.1.5 - ([316c934](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/316c93431a8b11194c46a465270dd053d4d591fa))
- Update Test scene with adjusted transforms, new GameObjects, and modified material properties - ([688b92c](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/688b92c1ad50eedd142bed2f8e304c8980895940))
- Adjust shader logic for depth sampling, noise, and blending; refine `_ScanSpeed` default value - ([6965529](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/69655297c18cfbf65efa73b011ea746024134d73))
- Update Digit.png.meta texture settings for filtering, compression, and platform-specific optimizations - ([42d87ce](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/42d87ce6e6ababe2106a66390a92fd6fe181b91a))
- Update NightVision animator with new states, parameters, and transitions for enhanced functionality - ([7e59e31](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/7e59e31b8c4f8ddabb3a4f381b66ce6d69b3bba4))
- Bump package version to 0.1.4 - ([c76a5a2](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/c76a5a2a6a1893809d88ddb400747a46d5e69474))
- Update animator controller and motion references with new GUIDs for compatibility - ([fbc6a08](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/fbc6a08b5631d6475e51a2c081edbbe2e5680207))
- Add `one.razgriz.rats` package and update project settings for compatibility - ([ed9c1dd](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/ed9c1ddbd1fb8a478a57ca50ac0f04b7d2e24655))
- Bump package version to 0.1.3 - ([4471023](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/447102332a466931ec3fdfd17890c876b222bde5))
- Update prefab references to use new GUIDs for animator and material - ([371d21a](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/371d21a0388663ef0594bdc07b453f19f2a02736))
- Bump package version to 0.1.2 - ([1a63067](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/1a6306788991aa13291edd6cb90c93c2563196ae))
- Update .asmdef configuration for improved Editor platform specificity and consistency - ([49b48b3](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/49b48b3ed5709c6cb20b0e704f0c11202b4dfcd1))
- Bump package version to 0.1.1 - ([909f213](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/909f213ab2fda2c2ec352c8b75a3322c9ec9f362))
- Bump package version to 0.1.0 - ([56f58a3](https://github.com/T2PeNBiX99wcoxKv3A4g/VPM.SimpleNightVision/commit/56f58a3a531609f72ff8a9c34904af791840476a))

## New Contributors ❤️

* @T2PeNBiX99wcoxKv3A4g made their first contribution

<!-- generated by git-cliff -->
