/*
 * patricia.h
 *
 * Patricia trie implementation.
 *
 * Functions for inserting nodes, removing nodes, and searching in
 * a Patricia trie designed for IP addresses and netmasks.  A
 * head node must be created with (key,mask) = (0,0).
 *
 * NOTE: The fact that we keep multiple masks per node makes this
 *       more complicated/computationally expensive then a standard
 *       trie.  This is because we need to do longest prefix matching,
 *       which is useful for computer networks, but not as useful
 *       elsewhere.
 *
 * Matthew Smart <mcsmart@eecs.umich.edu>
 *
 * Copyright (c) 2000
 * The Regents of the University of Michigan
 * All rights reserved
 *
 * $Id: patricia.h,v 1.1.1.1 2000/11/06 19:53:17 mguthaus Exp $
 */

#ifndef _PATRICIA_H_
#define _PATRICIA_H_

#include <stdint.h>

/*
 * Patricia tree mask.
 * Each node in the tree can contain multiple masks, so this
 * structure is where the mask and data are kept.
 */
#pragma pack(1)
struct ptree_mask
{
    uint32_t pm_mask;
    uint16_t pm_data;
};

/*
 * Patricia tree node.
 */
struct ptree
{
    uint32_t p_key;             /* Node key		    */
    struct ptree_mask p_m[3];   /* Node masks		*/
    uint8_t p_mlen;             /* Number of masks	*/
    int8_t p_b;                 /* Bit to check		*/
    struct ptree *p_left;       /* Left pointer		*/
    struct ptree *p_right;      /* Right pointer	*/
};
#pragma pack()

extern struct ptree *pat_insert(struct ptree *n, struct ptree *head);
extern int32_t pat_remove(struct ptree *n, struct ptree *head);
extern struct ptree *pat_search(uint32_t key, struct ptree *head);

#endif /* _PATRICIA_H_ */
