const REPLACE_PATTERN = /\u0000/g;
const HAIR_HASH = GetHashKey('hairOverlay');

function getString(buffer, offset, length = 64) {
    return String.fromCharCode.apply(null, new Uint8Array(buffer, offset, length)).replace(REPLACE_PATTERN, "");
}

function getTattooCollectionData(characterType, decorationIndex)
{
    let structArray = new Uint32Array(new ArrayBuffer(10 * 8));

    if (!Citizen.invokeNative("0xFF56381874F82086", characterType, decorationIndex, structArray)) {
        return null;
    }

    if (structArray[12] === HAIR_HASH)
    {
	    return {
	    	collection: structArray[4],
	    	hash: structArray[6]
	    };
    }
}

function getShopPedComponent(componentHash)
{
    let buffer = [ new ArrayBuffer(136) ];

    if (GetShopPedComponent(componentHash >> 0, buffer) === 0) {
        return null;
    }

    const { 0: lockHash, 2: uniqueNameHash, 4: locate, 6: drawableIndex, 8: textureIndex, 10: unk1, 12: eCompType, 14: unk2, 16: unk3 } = new Uint32Array(buffer[0]);

    return {
        lockHash,
        uniqueNameHash,
        locate,
        drawableIndex,
        textureIndex,
        unk1,
        eCompType,
        unk2,
        unk3,
        textLabel: getString(buffer[0], 72)
    };
}

function getShopPedProp(propHash)
{
    let buffer = [ new ArrayBuffer(136) ];

    if (GetShopPedProp(propHash >> 0, buffer) === 0) {
        return null;
    }

    const { 0: lockHash, 2: uniqueNameHash, 4: locate, 6: propIndex, 8: textureIndex, 10: unk1, 12: eAnchorPoint, 14: unk2, 16: unk3 } = new Uint32Array(buffer[0]);

    return {
        lockHash,
        uniqueNameHash,
        locate,
        propIndex,
        textureIndex,
        unk1,
        eAnchorPoint,
        unk2,
        unk3,
        textLabel: getString(buffer[0], 72)
    };
}

function getPedHeadBlendData(ped)
{
    let buffer = [ new ArrayBuffer(80) ];

    if (!GetPedHeadBlendData(ped, buffer)) {
        return null;
    }

    const {
        0: shapeFirstId, 2: shapeSecondId, 4: shapeThirdId,
        6: skinFirstId, 8: skinSecondId, 10: skinThirdId,
        18: isParent
    } = new Uint32Array(buffer[0]);

    const { 0: shapeMix, 2: skinMix, 4: thirdMix } = new Float32Array(buffer[0], 48);

    return {
        shapeFirstId, shapeSecondId, shapeThirdId,
        skinFirstId, skinSecondId, skinThirdId,
        shapeMix, skinMix, thirdMix,
        isParent: Boolean(isParent)
    };
}

exports("getTattooCollection", (characterType, decorationIndex) => {
	return getTattooCollectionData(characterType, decorationIndex);
});

exports("getShopPedComponent", (componentHash) => {
	return getShopPedComponent(componentHash);
});

exports("getShopPedProp", (propHash) => {
	return getShopPedProp(propHash);
});

exports("getPedHeadBlendData", (ped) => {
	return getPedHeadBlendData(ped);
});