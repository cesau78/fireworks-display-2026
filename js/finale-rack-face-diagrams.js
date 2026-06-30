/**
 * Face-view SVGs for wall boards (notch layout from layout.scad / config.scad).
 * Coordinates: origin bottom-left, x → right, y → up (inches).
 */

const WALL = {
  thick: 0.625,
  height: 3.5,
  lap: 1.75,
  dividerX: [-9, -5, -1.5625, 1.5625, 5, 9],
  rowBoardSpan: 24,
  columnLen: 18,
  columnY0: -9,
  endInnerFrontY: -7.6875,
  endInnerBackY: 7.6875,
};

function rowBoardX0(wIn) {
  return -wIn / 2;
}

function columnNotchXIn(i, boardX0) {
  return WALL.dividerX[i] - WALL.thick / 2 - boardX0;
}

function outsideRowBoardFace(wIn, hIn, fill = "#DC2626") {
  const x0 = rowBoardX0(wIn);
  const notches = [];
  for (let i = 0; i < 6; i++) {
    notches.push({
      x: columnNotchXIn(i, x0),
      y: hIn - WALL.lap,
      w: WALL.thick,
      h: WALL.lap,
    });
  }
  return { wIn, hIn, fill, notches };
}

function rowDividerFace(wIn, hIn, fill = "#3B82F6") {
  const x0 = rowBoardX0(wIn);
  const notches = [];
  for (let i = 0; i < 6; i++) {
    notches.push({
      x: columnNotchXIn(i, x0),
      y: 0,
      w: WALL.thick,
      h: WALL.lap,
    });
  }
  return { wIn, hIn, fill, notches };
}

function columnDividerFace(wIn, hIn, fill = "#F0F0F0") {
  const y0 = WALL.columnY0;
  const oyFront = WALL.endInnerFrontY - WALL.thick;
  const oyBack = WALL.endInnerBackY;
  const notches = [
    { x: oyFront - y0, y: 0, w: WALL.thick, h: WALL.lap },
    { x: oyBack - y0, y: 0, w: WALL.thick, h: WALL.lap },
  ];
  return { wIn, hIn, fill, notches };
}

const FACE_BY_PART_ID = {
  "wall-end": (p) => outsideRowBoardFace(p.cut_w_in, p.cut_h_in, p.color),
  "column-board-x": (p) => columnDividerFace(p.cut_w_in, p.cut_h_in, p.color),
  "middle-row-divider": (p) => rowDividerFace(p.cut_w_in, p.cut_h_in, p.color),
};

function fmtDim(n) {
  const eighths = Math.round(n * 8);
  const whole = Math.floor(eighths / 8);
  const rem = eighths % 8;
  const frac = ["", "1/8", "1/4", "3/8", "1/2", "5/8", "3/4", "7/8"];
  if (rem === 0) return String(whole);
  return whole ? `${whole}-${frac[rem]}` : frac[rem];
}

/**
 * @param {{ wIn: number, hIn: number, fill: string, notches: {x,y,w,h}[] }} spec
 */
export function renderBoardFaceSvg(spec) {
  const { wIn, hIn, fill, notches } = spec;
  const padL = 36;
  const padR = 36;
  const padHeader = 30;
  const padB = 40;
  const maxW = 300;
  const maxH = 72;
  const s = Math.min(maxW / wIn, maxH / hIn);
  const bw = wIn * s;
  const bh = hIn * s;
  const boardY = padHeader;
  const svgW = padL + bw + padR;
  const svgH = boardY + bh + padB;

  const notchPaths = notches
    .map((n) => {
      const x = padL + n.x * s;
      const y = boardY + bh - (n.y + n.h) * s;
      const w = Math.max(n.w * s, 1);
      const h = Math.max(n.h * s, 1);
      return `<rect x="${x.toFixed(2)}" y="${y.toFixed(2)}" width="${w.toFixed(2)}" height="${h.toFixed(2)}" fill="#0f1219" stroke="#94a3b8" stroke-width="0.75" stroke-dasharray="2 1"/>`;
    })
    .join("");

  const yTick = boardY + bh + 2;
  const yStartLbl = boardY + bh + 15;
  const yEndLbl = boardY + bh + 26;
  const notchMarks = notches
    .map((n) => {
      const xStart = padL + n.x * s;
      const xEnd = padL + (n.x + n.w) * s;
      return `<line x1="${xStart.toFixed(2)}" y1="${yTick}" x2="${xStart.toFixed(2)}" y2="${yTick + 4}" stroke="#64748b" stroke-width="0.75"/>
        <line x1="${xEnd.toFixed(2)}" y1="${yTick}" x2="${xEnd.toFixed(2)}" y2="${yTick + 4}" stroke="#64748b" stroke-width="0.75"/>
        <text x="${xStart.toFixed(2)}" y="${yStartLbl}" fill="#8b95a8" font-size="7" text-anchor="middle" font-family="Segoe UI, system-ui, sans-serif">${fmtDim(n.x)}</text>
        <text x="${xEnd.toFixed(2)}" y="${yEndLbl}" fill="#8b95a8" font-size="7" text-anchor="middle" font-family="Segoe UI, system-ui, sans-serif">${fmtDim(n.x + n.w)}</text>`;
    })
    .join("");
  const notchRowGuide = notches.length
    ? `<text x="${padL - 8}" y="${yStartLbl}" fill="#64748b" font-size="7" text-anchor="end" font-family="Segoe UI, system-ui, sans-serif">start</text>
       <text x="${padL - 8}" y="${yEndLbl}" fill="#64748b" font-size="7" text-anchor="end" font-family="Segoe UI, system-ui, sans-serif">end</text>`
    : "";

  const lapLbl = fmtDim(WALL.lap);
  const thickLbl = fmtDim(WALL.thick);
  const wLbl = fmtDim(wIn);
  const hLbl = fmtDim(hIn);

  const boardCx = padL + bw / 2;

  return `<svg class="rack-face-svg" viewBox="0 0 ${svgW} ${svgH}" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Board face ${wLbl} by ${hLbl} inches with notch layout">
    <text x="${boardCx}" y="12" fill="#93c5fd" font-size="11" font-weight="600" text-anchor="middle" font-family="Segoe UI, system-ui, sans-serif">${wLbl}" overall</text>
    <text x="${boardCx}" y="24" fill="#e8ecf4" font-size="9" text-anchor="middle" font-family="Segoe UI, system-ui, sans-serif">notch ${thickLbl}" × ${lapLbl}"</text>
    <rect x="${padL}" y="${boardY}" width="${bw}" height="${bh}" fill="${fill}" stroke="#cbd5e1" stroke-width="1"/>
    ${notchPaths}
    ${notchRowGuide}
    ${notchMarks}
    <line x1="${padL - 6}" y1="${boardY}" x2="${padL - 6}" y2="${boardY + bh}" stroke="#64748b" stroke-width="0.75"/>
    <text x="8" y="${boardY + bh / 2}" fill="#93c5fd" font-size="10" text-anchor="middle" font-family="Segoe UI, system-ui, sans-serif" transform="rotate(-90 8 ${boardY + bh / 2})">${hLbl}"</text>
  </svg>`;
}

function renderRodProfileSvg({ lengthIn, odIn, fill, label }) {
  const padL = 36;
  const padR = 36;
  const padT = 28;
  const padB = 28;
  const maxW = 300;
  const maxH = 56;
  const s = Math.min(maxW / lengthIn, maxH / odIn);
  const rw = lengthIn * s;
  const rh = Math.max(odIn * s, 8);
  const boardY = padT;
  const svgW = padL + rw + padR;
  const svgH = boardY + rh + padB;
  const cx = padL + rw / 2;
  const lenLbl = fmtDim(lengthIn);
  const odLbl = fmtDim(odIn);
  return `<svg class="rack-face-svg" viewBox="0 0 ${svgW} ${svgH}" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="${label} ${lenLbl} inches long, ${odLbl} inch diameter">
    <text x="${cx}" y="12" fill="#93c5fd" font-size="11" font-weight="600" text-anchor="middle" font-family="Segoe UI, system-ui, sans-serif">${lenLbl}" long</text>
    <text x="${cx}" y="24" fill="#e8ecf4" font-size="9" text-anchor="middle" font-family="Segoe UI, system-ui, sans-serif">${odLbl}" OD · side view</text>
    <rect x="${padL}" y="${boardY}" width="${rw}" height="${rh}" fill="${fill}" stroke="#cbd5e1" stroke-width="1"/>
    <line x1="${padL - 6}" y1="${boardY}" x2="${padL - 6}" y2="${boardY + rh}" stroke="#64748b" stroke-width="0.75"/>
    <text x="8" y="${boardY + rh / 2}" fill="#93c5fd" font-size="10" text-anchor="middle" font-family="Segoe UI, system-ui, sans-serif" transform="rotate(-90 8 ${boardY + rh / 2})">${odLbl}"</text>
  </svg>`;
}

const PROFILE_BY_PART_ID = {
  "dowel-row-top-middle": (p) =>
    renderRodProfileSvg({
      lengthIn: p.length_in,
      odIn: p.od_in,
      fill: p.color || "#D9BF59",
      label: "Outer dowel",
    }),
  "dowel-row-top-inner": (p) =>
    renderRodProfileSvg({
      lengthIn: p.length_in,
      odIn: p.od_in,
      fill: p.color || "#BF9E4D",
      label: "Inner dowel",
    }),
  "tube-mortar": (p) =>
    renderRodProfileSvg({
      lengthIn: p.length_in,
      odIn: p.od_in,
      fill: p.color || "#C4A06A",
      label: "Mortar tube",
    }),
};

export function faceDiagramForPart(part) {
  const board = FACE_BY_PART_ID[part.id];
  if (board && part.cut_w_in != null && part.cut_h_in != null) {
    return renderBoardFaceSvg(board(part));
  }
  const profile = PROFILE_BY_PART_ID[part.id];
  if (profile && part.length_in != null && part.od_in != null) {
    return profile(part);
  }
  return "";
}
