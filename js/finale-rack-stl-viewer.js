import * as THREE from "three";
import { OrbitControls } from "three/addons/controls/OrbitControls.js";
import { STLLoader } from "three/addons/loaders/STLLoader.js";

const CACHE_BUST = `?v=${Date.now()}`;

/** BOM part id → layered STL (full sub-assembly per color group). */
export const FINALE_RACK_STL_BY_PART_ID = {
  "wall-end": "outside-row-boards.stl",
  "column-board-x": "column-dividers.stl",
  "middle-row-divider": "row-dividers.stl",
  "dowel-row-top-middle": "outer-dowels.stl",
  "dowel-row-top-inner": "inner-dowels.stl",
  "tube-mortar": "mortar-tubes.stl",
};

export const FINALE_RACK_STL_BASE = "design/finale-mortar-rack/stl/";

export function previewPartsFromBom(bom, baseUrl = FINALE_RACK_STL_BASE) {
  if (!bom?.parts) return [];
  return bom.parts
    .filter((p) => p.color && FINALE_RACK_STL_BY_PART_ID[p.id])
    .map((p) => ({
      url: baseUrl + FINALE_RACK_STL_BY_PART_ID[p.id],
      color: p.color,
    }));
}

function bustUrl(url) {
  return url.includes("?") ? url : url + CACHE_BUST;
}

function orientZUp(geometry) {
  geometry.rotateX(-Math.PI / 2);
  return geometry;
}

function assemblyFit(geometries, targetSize = 2.5) {
  let minX = Infinity;
  let minY = Infinity;
  let minZ = Infinity;
  let maxX = -Infinity;
  let maxY = -Infinity;
  let maxZ = -Infinity;
  for (const g of geometries) {
    g.computeBoundingBox();
    const b = g.boundingBox;
    minX = Math.min(minX, b.min.x);
    minY = Math.min(minY, b.min.y);
    minZ = Math.min(minZ, b.min.z);
    maxX = Math.max(maxX, b.max.x);
    maxY = Math.max(maxY, b.max.y);
    maxZ = Math.max(maxZ, b.max.z);
  }
  const cx = (minX + maxX) / 2;
  const cy = minY;
  const cz = (minZ + maxZ) / 2;
  const maxDim = Math.max(maxX - minX, maxY - minY, maxZ - minZ);
  const scale = maxDim > 0 ? targetSize / maxDim : 1;
  return {
    scale,
    offset: new THREE.Vector3(-cx, -cy, -cz),
    height: (maxY - minY) * scale,
  };
}

function addLights(scene) {
  scene.add(new THREE.AmbientLight(0xffffff, 0.55));
  scene.add(new THREE.HemisphereLight(0xe8ecf4, 0x475569, 0.9));
  const key = new THREE.DirectionalLight(0xffffff, 2.4);
  key.position.set(5, 6, 4);
  scene.add(key);
  const fill = new THREE.DirectionalLight(0xffffff, 1.1);
  fill.position.set(-4, -2, -5);
  scene.add(fill);
  const rim = new THREE.DirectionalLight(0xffffff, 0.95);
  rim.position.set(0, 4, -6);
  scene.add(rim);
}

function meshFromGeometry(geometry, color) {
  const material = new THREE.MeshStandardMaterial({
    color,
    roughness: 0.38,
    metalness: 0.14,
  });
  const mesh = new THREE.Mesh(geometry, material);
  const edges = new THREE.EdgesGeometry(geometry, (28 * Math.PI) / 180);
  mesh.add(
    new THREE.LineSegments(
      edges,
      new THREE.LineBasicMaterial({ color: 0x64748b })
    )
  );
  return mesh;
}

function createViewerShell(container, label) {
  if (container._rackViewerDispose) {
    container._rackViewerDispose();
    container._rackViewerDispose = null;
  }
  container.replaceChildren();
  const wrap = document.createElement("div");
  wrap.className = "rack-stl-viewer";
  const canvasHost = document.createElement("div");
  canvasHost.className = "rack-stl-canvas";
  const status = document.createElement("p");
  status.className = "rack-stl-status";
  status.textContent = "Loading 3D model…";
  canvasHost.appendChild(status);
  const caption = document.createElement("div");
  caption.className = "rack-stl-caption";
  caption.textContent = label;
  wrap.appendChild(canvasHost);
  wrap.appendChild(caption);
  container.appendChild(wrap);
  return { wrap, canvasHost, status, caption };
}

/**
 * @param {HTMLElement} container
 * @param {{ parts?: { url: string, color?: string }[], url?: string, label?: string, color?: string, rotation?: [number, number, number] }} options
 */
export function mountFinaleRackViewer(container, options) {
  const {
    parts,
    url,
    label = "Drag to rotate",
    color = "#a8b4c4",
    rotation = [0, 35, 0],
  } = options;

  const { canvasHost, status } = createViewerShell(container, label);

  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(40, 1, 0.1, 1000);
  camera.position.set(3, 2, 3);

  const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
  renderer.setClearColor(0x000000, 0);
  canvasHost.appendChild(renderer.domElement);

  addLights(scene);

  const rotGroup = new THREE.Group();
  rotGroup.rotation.set(
    (rotation[0] * Math.PI) / 180,
    (rotation[1] * Math.PI) / 180,
    (rotation[2] * Math.PI) / 180
  );
  scene.add(rotGroup);

  const modelGroup = new THREE.Group();
  rotGroup.add(modelGroup);

  const controls = new OrbitControls(camera, renderer.domElement);
  controls.enablePan = false;
  controls.autoRotate = true;
  controls.autoRotateSpeed = 2;

  let frameId = 0;
  let disposed = false;
  let resizeObserver = null;

  function resize() {
    const w = canvasHost.clientWidth;
    const h = canvasHost.clientHeight;
    if (w < 1 || h < 1) return;
    camera.aspect = w / h;
    camera.updateProjectionMatrix();
    renderer.setSize(w, h, false);
  }

  function animate() {
    if (disposed) return;
    frameId = requestAnimationFrame(animate);
    controls.update();
    renderer.render(scene, camera);
  }

  resizeObserver = new ResizeObserver(resize);
  resizeObserver.observe(canvasHost);
  resize();
  animate();

  const loader = new STLLoader();

  function onModelReady(modelHeight) {
    if (disposed) return;
    status.remove();
    controls.target.set(0, modelHeight * 0.35, 0);
    resize();
  }

  function onLoadError(err) {
    if (disposed) return;
    status.textContent = `Could not load model (${err?.message || "error"})`;
    status.classList.add("rack-stl-status--error");
  }

  if (parts?.length) {
    Promise.all(
      parts.map(
        (p) =>
          new Promise((resolve, reject) => {
            loader.load(bustUrl(p.url), resolve, undefined, reject);
          })
      )
    )
      .then((geometries) => {
        if (disposed) {
          geometries.forEach((g) => g.dispose());
          return;
        }
        geometries.forEach(orientZUp);
        const { scale, offset, height } = assemblyFit(geometries);
        modelGroup.scale.setScalar(scale);
        modelGroup.position.copy(offset).multiplyScalar(scale);
        geometries.forEach((geo, i) => {
          modelGroup.add(meshFromGeometry(geo, parts[i].color || "#9ca3af"));
        });
        onModelReady(height);
      })
      .catch(onLoadError);
  } else if (url) {
    loader.load(
      bustUrl(url),
      (geometry) => {
        if (disposed) {
          geometry.dispose();
          return;
        }
        orientZUp(geometry);
        const { scale, offset, height } = assemblyFit([geometry]);
        modelGroup.scale.setScalar(scale);
        modelGroup.position.copy(offset).multiplyScalar(scale);
        modelGroup.add(meshFromGeometry(geometry, color));
        onModelReady(height);
      },
      undefined,
      onLoadError
    );
  } else {
    onLoadError(new Error("no model URL or parts"));
  }

  function dispose() {
    disposed = true;
    cancelAnimationFrame(frameId);
    resizeObserver?.disconnect();
    controls.dispose();
    rotGroup.traverse((obj) => {
      if (obj.geometry) obj.geometry.dispose();
      if (obj.material) {
        if (Array.isArray(obj.material)) obj.material.forEach((m) => m.dispose());
        else obj.material.dispose();
      }
    });
    renderer.dispose();
    container.replaceChildren();
    container._rackViewerDispose = null;
  }

  container._rackViewerDispose = dispose;
  return dispose;
}
