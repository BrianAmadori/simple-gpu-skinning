# Simple GPU Skinning

This is the simplest GPU skinning implementation possible on Unity. No texture encoding, no compute, no streamout.

It works by:
- Encoding the bone weight data in tangents and uv. This is a necessary step for the GPU skinning shader to work, and can introduce hiccups on the start if not handled carefully. Obviously, it needs to be processed once per mesh.
- Then, the bone matrices are sent each frame to the skinning shader.
- Finally, the shader does the skinning magic.
