Chris Busch

The following code must be added to act_comm.c in the MERC distribution.  I
encourage people to try to incorperate this code into their mud even if it
is not a MERC. 

#error

/*Add into file about line 604*/
/*cbusch was here*/
void chatperform(CHAR_DATA *ch,CHAR_DATA *victim,char* msg)
{ /*ch here should be a NPC, but its checked below*/
  char* reply;
  if( !IS_NPC(ch) || (victim!=NULL && IS_NPC(victim)) ) 
    return;  /*ignores ch who are PCs and victims who are NPCs*/
  reply=dochat(ch->name,msg, victim ? victim->name : "you" );
  if(reply) {
    switch(reply[0]) {
    case '\0': /* null msg*/ 
      break;
    case '"' : /*do say*/
      do_say(ch,reply+1);
      break;
    case ':' : /*do emote*/
      do_emote(ch,reply+1);
      break;
    case '!' : /*execute command thru interpreter*/
      interpret(ch, reply+1 );
      break;
    default : /* is a say or tell*/
      if(victim == NULL )         do_say(ch,reply);
      else { /* do a tell  (this is always the case here)*/
	act("$N tells you '$t'.",victim,reply,ch,TO_CHAR); 
	/*^^^^^^^^^^misnomer sends to victim*/
	victim->reply=ch;
      }
    }
  }
}

  
/*about line 637*/
/*cbusch was here*/
void chatperformtoroom( char *txt, CHAR_DATA *ch) 
{ /*ch here is the PC saying the phrase*/

  CHAR_DATA *vch;
  if( IS_NPC(ch)) return; /*we dont want NPCs trigger'ing events*/

  for ( vch = ch->in_room->people; vch != NULL; vch = vch->next_in_room )
    if ( IS_NPC( vch ) && !( vch->pIndexData->progtypes & SPEECH_PROG ) 
	&& IS_AWAKE(vch) )
      chatperform(vch,ch,txt);
  return;

}



/*add the chatperform line to do_tell function*/
void do_tell( CHAR_DATA *ch, char *argument )
{
  .........code removed........
    /*cbusch 8/21/95 about line 716*/
    chatperform(victim,ch,argument);
    /*cbusch end*/
    return;
}

/*add the chatperfrom line to do_reply function*/
void do_reply( CHAR_DATA *ch, char *argument )
{
    .........code removed.........
    /*cbusch 8/21/95 about line 756*/
    chatperform(victim,ch,argument); 
    /*cbusch end*/
    return;
}


/*add the chatperformtoroom line to do_emote function*/
void do_emote( CHAR_DATA *ch, char *argument )
{
  ....code deleted....
    /*cbusch was here*/
    chatperformtoroom(argument,ch);
    /*end cbusch was here*/
    return;
}
